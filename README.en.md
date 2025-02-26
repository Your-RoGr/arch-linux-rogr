![Version](https://img.shields.io/badge/Version-1.1.0-blue)
# Arch Linux

[English](README.en.md) | [Русский](README.md)

## Contents

- [Introduction](#Introduction)
- [Installation](#Installation)
- [Configuration](#Configuration)
- [Hotkeys](#Hotkeys)
- [Waybar](#Waybar)
- [GUI-Apps](#GUI-Apps)
- [Python Packages](#Python-Packages)
- [Forks](#Forks)
- [License](#License)

## Introduction

This repository is dedicated to a custom, independently developed x86-64 distribution of GNU/Linux - [Arch Linux](https://wiki.archlinux.org/title/Arch_Linux). This spin uses [Hyprland](https://hyprland.org/) as its window manager, a tiling Wayland compositor based on wlroots.

- Terminal - Alacritty
- Shell - Fish
![Alacritty](https://i.imgur.com/WTSGbaE.png)
- File manager - Thunar
- Wallpaper engine - swww
- Cursor - Breeze Snow
- Lock - swaylock
- Bar - Waybar

[](https://i.imgur.com/NX8Sc7X.png)
[](https://i.imgur.com/E5KNmAM.png)

## Installation

To install, you need to prepare a bootable USB with an Arch Linux image, for example, you can download the image and write it to a USB using Rufus for Windows:

- [Arch Linux](https://archlinux.org/download/)
- [Rufus](https://rufus.ie/en/)

1. After preparation, configure your BIOS, enabling UEFI and selecting the USB with the Arch Linux image as the primary boot device. Save and restart.

2. After restarting, the Arch Linux installation window should appear. Select the "Arch Linux install medium (x86_64, x64 UEFI)" option.

3. After the image is prepared for installation, you will see the "root@archiso" prompt. Install git and clone this repository:

```sh
pacman -Sy --noconfirm git
```

```sh
git clone https://github.com/Your-RoGr/arch-linux-rogr.git
```

4. Then, navigate to the git folder, give execution permissions, and run the installer (the installation process takes several minutes, depending on your internet speed and ROM speed):

```sh
cd arch-linux-rogr
```

```sh
chmod +x arch-installer.sh
```

```sh
./arch-installer.sh
```

5. Next, you need to enter your username, computer name, select a disk from the proposed options, select a [Time Zone](https://www.howtosop.com/linux-all-available-time-zones/), and agree to all questions (make sure you select the correct disk for the system). You can also format the disks as needed and then run the installation, for which you need to write "skip" instead of the disk. By default, two partitions are created:

- fat32 1MiB 513MiB (/boot)
- ext4 513MiB 100% (/)

6. Then, you need to set the root and user passwords

7. At the end of the installation, restart your computer after seeing the message (if your computer doesn't shut down automatically) and select the disk with /boot as the primary boot device in your BIOS:

```sh
[ OK ] Reached target System Power Off
```

8. Then, log in as your user and clone this repository again:

```sh
git clone https://github.com/Your-RoGr/arch-linux-rogr.git
```

9. Next, navigate to the git folder, give execution permissions, and run the post-installation script (the installation process takes a significant amount of time, depending on your i
cd arch-linuxnternet speed and ROM speed):

```sh
cd arch-linux-rogr
```

```sh
chmod +x arch-post-installation.sh
```

```sh
./arch-post-installation.sh
```

10. At the beginning of the installation, you need to select a video driver (1 - nvidia (for GTX 750 and newer), 2 - amd), or skip if your video card doesn't meet the requirements (install drivers manually).

11. Wait for the installation to complete and enjoy using Arch Linux with Hyprland!

> You may need to restart

### Additional

1. You can install CUDA (if you have a GTX 1050 or newer video card) and/or a Python virtual environment with Jupyter Lab and Python packages from requirements.txt:

```sh
./python-installer.sh
```

> To work with the environment, use the following command:

```sh
source ~/jupyterlab/bin/activate.fish
```

2. You can set up a PostgreSQL user:

```sh
sudo su - postgres
```

```sh
psql -c "alter user postgres with password 'postgres'"
```

```sh
exit
```

3. You can install pgadmin4, which requires additional settings:

```sh
chmod +x pgadmin.sh
```

```sh
./pgadmin.sh
```

## Configuration

1. Configuring multiple monitors. [Link to documentation](https://wiki.hyprland.org/Configuring/Monitors/). By default, it is configured automatically. The line in ~/.config/hypr/hyprland.conf (after installation):

```conf
monitor=,preferred,auto,1
```

2. Wallpapers need to be copied to the ~/.config/wallpapers directory. The following formats are supported: jpeg, png, gif, pnm, tga, tiff, webp, bmp, farbfeld

3. Waybar, swaylock, swww, rofi, hypridle (hypr), and alacritty have their own configuration files for external appearance and functionality, which are located in their respective directories.

> You can familiarize yourself with other Hyprland settings in the [documentation](https://wiki.hyprland.org/) and perform them in the ~/.config/hypr/hyprland.conf file.

## Hotkeys

All hotkeys for the system are described in the ~/.config/hypr/hyprland.conf file (after installation). The Win key == Super.

1. System:

- Win + W - Hide/show Waybar.
- Win + Shift + W - Update Waybar.
- Win + Left Ctrl + Shift + W - Restart Waybar.
- Win + Left Ctrl + Shift + K - Exit Hyprland.
- Win + L - Lock screen.
- Win + C - Color picker (copies color to buffer).
- Win + PrtScr - Take a screenshot of the entire screen (copies screenshot to buffer).
- PrtScr - Take a screenshot of an area (copies screenshot to buffer).
- Win + [0-9] - Switch workspace.
- Win + Scroll - Switch workspace.

- Alt + Tab - Switch workspace.

Here is the translation:

**2. Opening windows:**

- Win + E - Open Thunar file manager.
- Win + R - Open Rofi application menu.
- Win + T - Open Alacritty terminal.
- Win + U - Open cpupower menu for processor frequency settings.
- Win + I - Open Wi-Fi menu (iwgtk).
- Win + O - Open clock application.
- Win + P - Open power menu.
- Win + H - Open htop.
- Win + Shift + H - Open bashtop.
- Win + B - Open Bluetooth menu (blueberry).
- Win + N - Open nvtop.
- Win + M - Open mixer (pavucontrol).

**3. Working with windows:**

- Win + Q - Close active window.
- Win + S - Open/close hidden workspace.
- Win + Shift + S - Move active window to hidden workspace.
- Win + F - Make active window full screen.
- Win + J - Change window orientation type.
- Win + V - Change active window property - floating.
- Win + Arrow - Change focus to another window.
- Win + Shift + Arrow - Swap active window with another one.
- Win + Left Ctrl + Arrow - Resize active window.
- Win + Shift + [0-9] - Move active window to another workspace.
- Win + LMB - Move window.
- Win + RMB - Resize window (if floating).

## Waybar

![Waybar](https://i.imgur.com/WDCXDHh.png)

> In this case, workspaces start from 2, as it is the second monitor

**1. Clock**

- LMB: Change time format.
- RMB: Open Clock GUI
- Mouse hover: Show calendar

**2. Workspaces**

- LMB: Switch to workspace
- Mouse wheel: Switch to another workspace

**3. Applications (All except Alacritty)**

- LMB: Switch to application
- RMB: Close application
- Mouse hover: Show window title

**4. CPU temperature, CPU load, RAM, battery charge (if available)**

- RMB: Open cpupower GUI
- Mouse hover: Show status

**5. Background applications**

- RMB: Open application menu
- Mouse hover: Show application name

**6. Internet**

- RMB: Open iwgtk GUI
- Mouse hover: Show status

**7. Language**

- LMB: Change language, only for the main keyboard

**8. Bluetooth**

- LMB: Enable/disable bluetoothctl
- RMB: Open blueberry GUI
- Mouse hover: Show connected device

**9. Power modes**

- LMB: Change power mode
- Mouse hover: Show current settings

**10. Monitor brightness**

- Mouse wheel: Change value

**11. Volume**

- LMB: Mute/unmute sound
- RMB: Open mixer GUI
- Mouse hover: Show connected device
- Mouse wheel: Change value

**12. Power menu**

- LMB: Open Power menu

## GUI-Apps

![GUI-Apps](https://i.imgur.com/A7oeCKL.png)

> The screenshot above is: Win + R - Open Rofi application menu.

List of installed GUI applications:

**1. Media:**

- VLC (Media player)
- OBS Studio (Live streaming and video recording)
- Inkscape (Vector graphics editor)
- Blender (3D image creation package)
- Krita (Digital painting)
- Eye of GNOME (Image viewer)
- imv (Image viewer)

**2. Documents:**

- LibreOffice (Document editor)
- ONLYOFFICE (Document editor)
- Cudatext (Text file editor)
- Obsidian (Markdown-based knowledge base)
- Evince (E-book reader)

**3. Developer tools:**

- Visual Studio Code [Code - OSS] (General-purpose IDE)
- Docker desktop (Containerization tool)
- PostBird (PostgreSQL client)
- Postman (Web API testing platform)
- DB Browser for SQLite
- PyCharm Community Edition (Python IDE)
- PyCharm Professional (Python IDE with advanced features)
- GoLand (Golang IDE)
- CLion (C++ IDE)
- Figma (Website prototyping)
- Godot Engine (Game development)
- Godot Mono (C#/.NET game development)

**4. Networking:**

- WebCord (Discord)
- Telegram-desktop
- Yandex Browser
- Google Chrome
- Firefox

**5. Games:**

- Steam (Game store)

**6. Other:**

- FileZilla (FTP client)
- PortProton (Run .exe files under Windows)
- ProtonUp (Update proton for Steam and PortProton)
- Disks (Easy disk management)
- File Roller (Archiver)
- Filelight (Graphical disk usage analyzer)
- Piper (Application to configure gaming mice)

## Python Packages

You can familiarize yourself with Python packages and change them as needed in requirements.txt. Additional information can be found in [PyPI](https://pypi.org/) or in the package developers' documentation.

## Forks

Currently, there are trusted forks of the spin:

- [arch-linux-rogr](https://github.com/Your-RoGr/arch-linux-rogr)
- [arch-linux-ML](https://github.com/Your-RoGr/arch-linux-ML)
- [arch-linux-extra](https://github.com/Extragenchik/arch-linux-extra)

## License

MIT

**Free Software, Hell Yeah**
