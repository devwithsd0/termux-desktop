#!/data/data/com.termux/files/usr/bin/bash
declare -r DOWNLOAD_LINK="https://www.github.com/devwithsd0/termux-desktop/raw/refs/heads/master"
function ask {
	if [ "${2:-}" = "Y" ]; then
		local default="Y"
		local prompt="Y/n"
	elif [ "${2:-}" = "N" ]; then
		local default="N"
		local prompt="y/N"
	else
		echo "Invalid argument detected."
		exit 1
	fi
	read -p "$1 [$prompt] " reply
	echo ""
	while true; do
		case "$reply" in
			Y*|y*) return 0;;
			N*|n*) return 1;;
			*) reply="$default";;
		esac
	done
}
function ready {
	local A=
	local succeed=false
	while true; do
		if "$succeed"; then
			echo "Completed installing $1 successfully."
			break
		elif [ -n "$(command -v $2)" ]; then
			echo "Found $1 previously installed."
			break
		fi
		if [ "$A" = "..." ]; then
			if ask "Progress is stopping repeatedly. Changing repository could help improving speed. Open wizard?" Y; then
				termux-change-repo
			else
				echo "Looking for fatal exceptions..."
				dpkg --configure -a || {
					echo "Trying to fix..."
					pkg install -f -y && echo "Done running." || {
						echo "Failed! Kindly find for manual solutions."
						exit 1
					}
				}
			fi
			A=".."
		fi
		pkg install "$1" -y && succeed=true || echo "Package $1 not installed." && A="$A."
	done
}
function extract {
	if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
		echo "Please give more arguments to process."
		exit 1
	fi
	local extension="$(echo $1 | tr + .)"
	local name="$HOME/download.$extension"
	while true; do
		wget --no-hsts -c "$DOWNLOAD_LINK/$2" -O "$name" && {
			echo "Completed saving!"
			break
		}
		echo "Download stopped. Retrying..."
		sleep 3
	done
	if [ ! -d "$3" ]; then
		mkdir -p "$3"
		echo "New directory created."
	fi
	echo "Extracting..."
	if [ "$extension" = "none" ]; then
		mv "$name" "$3/$(basename $2)"
	elif [ ! "$extension" = "$(echo $extension | sed 's/tar//')" ]; then
		tar -xf "$name" -C "$3"
	elif [ "$extension" = "zip" ]; then
		unzip "$name" -d "$3"
	else
		echo "Unexpected type inputted."
		exit 1
	fi
	rm -f "$name"
}
function preview {
	clear
	echo ""
	echo ""
	echo -e "  \033[95m->\033[0m Title: $1"
	echo -e "  \033[95m->\033[0m Contains: $2"
	echo -e "  \033[95m->\033[0m Size: $3 ($4 to download)"
	echo ""
	echo ""
	eval return "$(ask 'Install this one?' N)"
}
case "$1" in
	I*|i*) {
		if ! ping -c 1 -W 1 8.8.8.8 &> "/dev/null"; then
			echo "Network latency is high. It is not safe to start."
			exit 1
		fi
		declare -i selected="$(dialog --output-fd 1 --title 'Termux Desktop Environment' --menu 'Which one will you choose?' 9 45 0 1. Xfce 2. LXQt | sed 's/\.//g')"
		clear
		if [ "$selected" = 0 ]; then
			echo "No problem. When you feel comfortable, come back then later."
			exit 1
		fi
		echo "Remaining time depends on connection strength. Commonly you should wait for a while."
		ready sox play
		ready wget wget
		ready x11-repo
		ready tigervnc vncserver
		clear
		echo -e "[\033[93m*\033[0m] Installing..."
		if [ $selected = 1 ]; then
			ready kitty kitty
			ready lxappearance lxappearance
			ready xfce4-battery-plugin
			ready xfce4-clipman-plugin xfce4-clipman
			ready xfce4-mailwatch-plugin
			ready xfce4-notifyd xfce4-notifyd-config
			ready xfce4-places-plugin xfce4-popup-places
			ready xfce4-screenshooter xfce4-screenshooter
			ready xfce4-taskmanager xfce4-taskmanager
			ready xfce4-wavelan-plugin
			ready xfce4-whiskermenu-plugin xfce4-popup-whiskermenu
			ready xfdesktop xfdesktop
			ready xfwm4 xfwm4
		elif [ $selected = 2 ]; then
			ready alacritty alacritty
			ready gvfs
			ready libnotify notify-send
			ready lxqt-about lxqt-about
			ready lxqt-config lxqt-config
			ready lxqt-notificationd lxqt-notificationd
			ready lxqt-panel lxqt-panel
			ready lxqt-qtplugin
			ready openbox openbox
			ready pavucontrol-qt pavucontrol-qt
			ready pcmanfm-qt pcmanfm-qt
			ready scrot scrot
		fi
		echo -e "[\033[93m*\033[0m] Getting ready..."
		extract none "Resources/Configurations/xsmgmt" "$PREFIX/bin"
		extract tar+xz "Resources/Configurations/1.tar.xz" "$HOME/.local/share/pixmaps"
		extract tar+xz "Resources/Themes/3.tar.xz" "$HOME/.local/share/themes"
		extract tar+xz "Resources/Wallpapers/3.tar.xz" "$HOME/.local/share/wallpapers/unreal"
		if [ $selected = 1 ]; then
			extract zip "Resources/Configurations/xfce.zip" "$HOME"
			extract tar+xz "Resources/Icons/1.tar.xz" "$HOME/.local/share/icons"
			extract tar+xz "Resources/Icons/2.tar.xz" "$HOME/.local/share/icons"
		elif [ $selected = 2 ]; then
			extract zip "Resources/Configurations/lxqt.zip" "$HOME"
			extract tar+xz "Resources/Icons/3.tar.xz" "$HOME/.local/share/icons"
			extract tar+xz "Resources/Themes/14.tar.xz" "$HOME/.local/share/lxqt/themes"
		fi
		echo -e "[\033[93m*\033[0m] Almost there."
		chmod +x "$PREFIX/bin/xsmgmt"
		chmod +x "$HOME/.vnc/xstartup"
		if ask "There is only a few resources for customization. Want to visit and download something from my collection?" Y; then
			while true; do
				if [ "$selected" = 1 ]; then
					if preview "Vimix Beryl" "Icon Pack + Cursors" "20.8 MB" "2.17 MB"; then
						extract tar+xz "Resources/Icons/3.tar.xz" "$HOME/.local/share/icons"
					fi
					if preview "Vimix Doder" "Icon Pack" "20.8 MB" "2.22 MB"; then
						extract tar+xz "Resources/Icons/4.tar.xz" "$HOME/.local/share/icons"
					fi
					if preview "Colloid Teal" "Themes" "3.09 MB" "144 KB"; then
						extract tar+xz "Resources/Themes/1.tar.xz" "$HOME/.local/share/themes"
					fi
					if preview "Graphite Green" "Themes" "3 MB" "140 KB"; then
						extract tar+xz "Resources/Themes/2.tar.xz" "$HOME/.local/share/themes"
					fi
					if preview "Android Green" "Themes" "2.58 MB" "152 KB"; then
						extract tar+xz "Resources/Themes/4.tar.xz" "$HOME/.local/share/themes"
					fi
				elif [ $selected = 2 ]; then
					if preview "Fluent" "Cursors" "6.3 MB" "263 KB"; then
						extract tar+xz "Resources/Icons/1.tar.xz" "$HOME/.local/share/icons"
					fi
					if preview "Tela Android" "Icon Pack" "16.6 MB" "2.54 MB"; then
						extract tar+xz "Resources/Icons/2.tar.xz" "$HOME/.local/share/icons"
					fi
					if preview "Vimix Doder" "Icon Pack" "20.8 MB" "2.22 MB"; then
						extract tar+xz "Resources/Icons/4.tar.xz" "$HOME/.local/share/icons"
					fi
					if preview "Joy" "Themes" "7.66 KB" "1.52 KB"; then
						extract tar+xz "Resources/Themes/6.tar.xz" "$HOME/.local/share/themes"
					fi
					if preview "Lovely" "Themes" "7.7 KB" "1.54 KB"; then
						extract tar+xz "Resources/Themes/7.tar.xz" "$HOME/.local/share/themes"
					fi
					if preview "Nord Dark" "Themes" "9.18 KB" "1.57 KB"; then
						extract tar+xz "Resources/Themes/8.tar.xz" "$HOME/.local/share/themes"
					fi
					if preview "Prismatic Night" "Themes" "9.37 KB" "2.14 KB"; then
						extract tar+xz "Resources/Themes/9.tar.xz" "$HOME/.local/share/themes"
					fi
					if preview "Raven Crimson" "Themes" "5.47 KB" "1.66 KB"; then
						extract tar+xz "Resources/Themes/10.tar.xz" "$HOME/.local/share/themes"
					fi
					if preview "Arch Linux" "LXQt Style" "3.25 MB" "3.23 MB"; then
						extract tar+xz "Resources/Themes/11.tar.xz" "$HOME/.local/share/lxqt/themes"
					fi
					if preview "Ice" "LXQt Style" "8.72 MB" "8.6 MB"; then
						extract tar+xz "Resources/Themes/12.tar.xz" "$HOME/.local/share/lxqt/themes"
					fi
					if preview "Valendas" "LXQt Style" "999 KB" "966 KB"; then
						extract tar+xz "Resources/Themes/13.tar.xz" "$HOME/.local/share/lxqt/themes"
					fi
				fi
				if preview "Arc Darkest" "Themes" "2.49 MB" "188 KB"; then
					extract tar+xz "Resources/Themes/5.tar.xz" "$HOME/.local/share/themes"
				fi
				if preview "Anime Life" "Wallpaper Pack" "28.1 MB" "27.9 MB"; then
					extract tar+xz "Resources/Wallpapers/1+p1.tar.xz" "$HOME/.local/share/wallpapers/anime"
					extract tar+xz "Resources/Wallpapers/1+p2.tar.xz" "$HOME/.local/share/wallpapers/anime"
				fi
				if preview "Huge and Clear Pics" "Wallpaper Pack" "30.4 MB" "28.3 MB"; then
					extract tar+xz "Resources/Wallpapers/2+p1.tar.xz" "$HOME/.local/share/wallpapers/huge"
					extract tar+xz "Resources/Wallpapers/2+p2.tar.xz" "$HOME/.local/share/wallpapers/huge"
					extract tar+xz "Resources/Wallpapers/2+p3.tar.xz" "$HOME/.local/share/wallpapers/huge"
				fi
			done
		fi
		echo -e "[\033[93m*\033[0m] Cleaning up temporary files..."
		pkg uninstall x11-repo -y
		apt autoremove -y
		pkg clean
		pkg autoclean
		echo -e "[\033[94m=\033[0m] Finished! Enjoy your new pocket computer!"
		echo -e "[\033[94m=\033[0m] Tip: Type 'xsmgmt start' to start a new session of your Computer."
		echo -e "[\033[94m=\033[0m] Tip: Type 'xsmgmt stop' to stop any previously started session."
		echo -e "[\033[94m=\033[0m] Fact: Create a new profile targeted at 'localhost:1' and set the picture quality to 'High' for experiencing the best performance across 'VNC Viewer' application."
		exit
	};;
	U*|u*) {
		if ask "Installed applications, necessary files and settings could be hampered. It is dangerous if you are not alerted what will happen! Really continue?" N; then
			if ask "LAST CHANCE!!! I care about your personal informations. Surely destroy your pocket computer? (hoping for negative answer)" N; then
				echo "Please do not try to interrupt the process here. Or else your 'Termux' could badly damaged. Seriously!"
				sleep 3
				clear
				echo -e "[\033[93m*\033[0m] Getting ready..."
				pkg uninstall --purge alacritty gvfs kitty libnotify lxappearance lxqt-about lxqt-config lxqt-notificationd lxqt-panel lxqt-qtplugin openbox pavucontrol-qt pcmanfm-qt scrot sox tigervnc xfce4-battery-plugin xfce4-clipman-plugin xfce4-mailwatch-plugin xfce4-notifyd xfce4-places-plugin xfce4-screenshooter xfce4-taskmanager xfce4-wavelan-plugin xfce4-whiskermenu-plugin xfdesktop xfwm4 -y
				apt autoremove --purge -y
				echo -e "[\033[93m*\033[0m] Permanently deleting..."
				rm -r -v "$HOME/.config" "$HOME/.icons" "$HOME/.local" "$HOME/.vnc" "$HOME/.gtkrc-2.0" "$PREFIX/share/icons" "$PREFIX/bin/xsmgmt"
				echo -e "[\033[94m=\033[0m] Hope to see you again. Thanks for using. Byee!"
				exit
			fi
		fi
		echo "Not continued."
		echo "Left everything intact."
	};;
	*) {
		echo ""
		echo "No command received."
		echo ""
		echo "Usage: $0 <install|uninstall>"
		echo ""
		exit 1
	};;
esac