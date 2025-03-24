#!/bin/bash

sudo rm -rf /local

# sudo cp pacman/pacman.conf /etc/pacman.conf

sudo pacman -Syyu --noconfirm
sudo pacman -Sy --noconfirm intel-media-driver
sudo pacman -Sy --noconfirm libva-intel-driver
sudo pacman -Sy --noconfirm libva-intel-driver libva-mesa-driver mesa-vdpau

echo "Enter your GPU manufacturer [1 - nvidia (For GTX 750 and newer), 2 - amd or skip] (press enter for default: 1):"
read vendor
vendor=$(echo $vendor | tr -cd '[:alnum:]_-')
vendor=${vendor:-1}
echo "You entered: $vendor"

if [[ "${vendor:0:4}" == "skip" ]]; then
    echo "Driver installing skipped"
elif [[ $vendor =~ ^[0-9]+$ ]]; then
    if [ "$vendor" -eq 1 ]; then
        echo "Installing Nvidia drivers..."

        sudo mkdir /etc/pacman.d/hooks

        cat << EOL | sudo tee /etc/pacman.d/hooks/nvidia.hook > /dev/null
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux
# Измените "linux" в строке выше, если вы используете другое ядро

[Action]
Description=Update NVIDIA module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux*) exit 0; esac; done; /usr/bin/mkinitcpio -P'
EOL

        # proprietary driver
        sudo pacman -Sy --noconfirm nvidia nvidia-utils nvidia-settings lib32-nvidia-utils nvtop
        # Enable the nvidia service
        sudo systemctl enable nvidia-persistenced.service

        cat << EOL | sudo tee /etc/modprobe.d/nvidia_drm.conf > /dev/null
options nvidia_drm modeset=1
EOL

    elif [ "$vendor" -eq 2 ]; then
        echo "Installing AMD drivers..."
        sudo pacman -Sy --noconfirm xf86-video-amdgpu mesa mesa-demos vulkan-icd-loader lib32-mesa lib32-vulkan-icd-loader
        # Enable the amdgpu service (if necessary)
        sudo systemctl enable amdgpu-init.service
    else
        echo "Invalid entry. Please enter either 1 or 2."
    fi
else
    echo "Invalid entry. Please enter either 1 or 2."
fi

# Install ntp
echo "Installing ntp"
sudo pacman -Sy --noconfirm ntp
sudo systemctl enable ntpd

# Install YAY
echo "Installing git, base-devel, wget and YAY"
sudo pacman -Sy --noconfirm git base-devel wget
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

cd ..
rm -rf ~/yay

# Install Japanese tools
sudo pacman -Sy --noconfirm fcitx fcitx-qt5 fcitx-im fcitx-configtool
sudo pacman -Sy --noconfirm fcitx-mozc fcitx-anthy

mkdir -p ~/.config/fcitx
cp fcitx/config ~/.config/fcitx/config

# Install font
echo "Installing fonts"
# RU-US fonts
sudo pacman -Sy --noconfirm ttf-jetbrains-mono ttf-roboto ttf-bitstream-vera ttf-croscore ttf-dejavu
sudo pacman -Sy --noconfirm ttf-droid gnu-free-fonts ttf-ibm-plex ttf-input libertinus-font noto-fonts gsfonts
sudo pacman -Sy --noconfirm ttf-cascadia-code ttf-fantasque-sans-mono otf-fantasque-sans-mono ttf-fira-mono otf-fira-mono
sudo pacman -Sy --noconfirm ttf-hack otf-hermit ttc-iosevka ttf-monofur ttf-roboto-mono cantarell-fonts ttf-fira-sans
sudo pacman -Sy --noconfirm ttf-liberation otf-montserrat ttf-nunito ttf-opensans adobe-source-sans-fonts otf-crimson
sudo pacman -Sy --noconfirm ttf-linux-libertine tex-gyre-fonts ttf-croscore ttf-ubuntu-font-family ttf-fira-code
sudo pacman -Sy --noconfirm otf-fira-sans inter-font ttf-gentium-plus
yay -Sy --noconfirm ttf-ms-fonts ttf-vista-fonts ttf-b612 font-bh-ttf ttf-courier-prime
yay -Sy --noconfirm ttf-envy-code-r
yay -Sy --noconfirm ttf-comic-mono-git ttf-dmcasansserif otf-jost ttf-tahoma
yay -Sy --noconfirm otf-bodoni ebgaramond-otf ttf-heuristica ttf-librebaskerville otf-libre-caslon

yay -Sy --noconfirm otf-londrina otf-tesla ttf-architects-daughte

yay -Sy --noconfirm ttf-paratype otf-russkopis

# Emoji Fonts
sudo pacman -Sy --noconfirm noto-fonts-emoji ttf-joypixels
yay -Sy --noconfirm	ttf-twemoji otf-openmoji ttf-twemoji-color ttf-symbola noto-color-emoji-fontconfig

# Math Fonts
yay -Sy --noconfirm ttf-cm-unicode otf-cm-unicode otf-stix tex-gyre-math-fonts

# japanese fonts
sudo pacman -Sy --noconfirm adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts noto-fonts-cjk otf-ipafont otf-ipaexfont ttf-hanazono ttf-sazanami
yay -Sy --noconfirm ttf-koruri ttf-mplus-git ttf-vlgothic ttf-kanjistrokeorders

fc-cache -fv

# Install alacritty
echo "Installing alacritty"
sudo pacman -Sy --noconfirm alacritty

# install xdg
echo "Installing xdg"
sudo pacman -Sy --noconfirm xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-wlr xdg-utils kde-cli-tools

# Install other soft
echo "Installing clang, gdb, ninja, gcc, cmake, fastfetch, htop, bashtop, fish, lf, neovim"
sudo pacman -Sy --noconfirm clang gdb ninja gcc cmake fastfetch htop bashtop fish lf neovim

sudo systemctl enable systemd-homed
sudo systemctl start systemd-homed

echo "Installing brightnessctl"
sudo pacman -Sy --noconfirm brightnessctl

echo "Installing iwgtk"
yay -Sy --noconfirm iwgtk
sudo systemctl enable iwd.service
sudo systemctl start iwd.service

echo "Installing cpupower-gui-git"
yay -Sy --noconfirm cpupower-gui-git

echo "Installing python package"
sudo pacman -Sy --noconfirm python-requests

echo "Installing audio drivers: pipewire/alsa"
sudo pacman -Sy --noconfirm alsa-lib alsa-plugins alsa-tools alsa-utils
sudo pacman -Sy --noconfirm pipewire pipewire-alsa pipewire-pulse pipewire-jack pipewire-audio pavucontrol bluez bluez-utils blueberry
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

cat << EOL | sudo tee /etc/modprobe.d/snd_intel_dspcfg.conf > /dev/null
options snd_intel_dspcfg dsp_driver=1
EOL

# For screencast
echo "Installing xdg-desktop-portal-hyprland"
sudo pacman -Sy --noconfirm xdg-desktop-portal-hyprland
sudo pacman -Sy --noconfirm xdg-desktop-portal-wlr

echo "Installing piper"
sudo pacman -Sy --noconfirm piper

cat << EOL | sudo tee /usr/share/libratbag/logitech-g102-g203.device > /dev/null
# G102, G103 and G203 (USB)
[Device]
Name=Logitech Gaming Mouse G102/G103/G203
DeviceMatch=usb:046d:c084;usb:046d:c092;usb:046d:c09d
Driver=hidpp20
LedTypes=logo;side;
DeviceType=mouse
EOL

chmod +x hyprland-installer.sh
./hyprland-installer.sh
