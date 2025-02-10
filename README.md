# Hello!
Wanna experience how a computer is? Or looking for easy solutions? Then you came at the right place. I'll help you a lot!


# What is this?
This is an advanced collection of configurations for __Termux X11__ packages. Rich in accessibilities to be highly functional, good looking and the most lightweight ever created!

Inspired by @Yisus7u7 resulting a similar Desktop Environment that almost all Operating System has.


# Screenshots
First have a look on some pictures to choice.
## LXQt
> Made like: Apple MacOS

![How is it?](https://www.github.com/devwithsd0/termux-desktop/raw/refs/heads/master/Demonstrations/2025-02-06-172006_1024x768_scrot.png)
## Xfce
> Made like: Windows 10

![How is it?](https://www.github.com/devwithsd0/termux-desktop/raw/refs/heads/master/Demonstrations/2025-02-06-202217_1024x768_scrot.png)

> As current release was actually focused on optimizing, I've tried as much as possible to make it user-friendly. But could contain feature lack. Feel free to open an issue.

# More
> Want more pictures to see? Here it is:

> Of LXQt:

![Notepad + VLC Media Player: Endermanch (again not promoting.)](https://www.github.com/devwithsd0/termux-desktop/raw/refs/heads/master/Demonstrations/2025-02-06-173556_1024x768_scrot.png)
![ShotCut: how much powerful it is?! (Required Resolution: 1920x1080)](https://www.github.com/devwithsd0/termux-desktop/raw/refs/heads/master/Demonstrations/2025-02-06-174909_1920x1080_scrot.png)

> Of Xfce:

![Terminal + Task Manager](https://www.github.com/devwithsd0/termux-desktop/raw/refs/heads/master/Demonstrations/Screenshot_2025-02-06_20-34-02.png)
![File Manager + About the Computer + Geany Code Editor](https://www.github.com/devwithsd0/termux-desktop/raw/refs/heads/master/Demonstrations/Screenshot_2025-02-07_07-31-47.png)
![Mozilla Firefox: YouTube - mcaddon (Not promoting. Just for showing how hard graphics can it load.)](https://www.github.com/devwithsd0/termux-desktop/raw/refs/heads/master/Demonstrations/Screenshot_2025-02-07_08-00-47.png)


# Themes
Aside from the pictures above, there are many more `Icon Packs`, `Themes` you can change from `Settings`. There's tons of wallpaper too! But you need to download them.

Don't worry! You'll be prompted to download while installing.


# Requirements
- No need of Root Permission.
- an Android 7+ phone.
- 512 MB of RAM & 896 MB of ROM (minimum).
- Termux 0.118.1+ [(GitHub version)](https://www.apkmirror.com/apk/fredrik-fornwall/termux-github-version) / [(F-Droid version)](https://f-droid.org/en/packages/com.termux)
> Termux from Play Store is unmaintained due to API related problems and not recommended.
- [VNC Viewer](https://apkpure.com/vnc-viewer-remote-desktop/com.realvnc.viewer.android)
> You can also use alternatives from Play Store like bVNC Pro or even noVNC etc.


# Installation
Step 1: Update your repository list.
```bash
pkg --check-mirror upgrade -y
```
Step 2: Download `wget` and then the main script.
```bash
pkg install wget -y
```
```bash
wget https://www.github.com/devwithsd0/termux-desktop/raw/refs/heads/master/setup.sh
```
Step 3: Start the mission of installation.
```bash
bash setup.sh install
```
After that, just take a cupcake and it'll do it's job. (🧁)


# Uninstallation
I never want to loss you! But if your mind makes the decision, then I've nothing to do. (😟)
```bash
bash setup.sh uninstall
```


# Usage
Run:
> To start.
```bash
xsmgmt start
```
> To stop.
```bash
xsmgmt stop
```


# Tips and Tricks
- How to change the resolution?

To change resolution, just run this command to open a file for editing.
```bash
nano ~/.vnc/config
```
Then uncomment the line `# geometry=2000x1200` and put anything you like but should be valid. An example (best for gaming):
```bash
geometry=1920x1080
```


# Thanks!
Hope you like it. This little work is standing only on your support. (😉)

Found something missing? Report [here](https://www.github.com/devwithsd0/termux-desktop/issues). (🚨)

Don't forget to leave your (🌟) and share. Till then, GOODBYE!
