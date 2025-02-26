#!/bin/bash

mkdir -p ~/.config/hypr
mkdir -p ~/.config/waybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/swaylock
mkdir -p ~/.config/swww
mkdir -p ~/.config/Thunar
mkdir -p ~/.config/alacritty
sudo mkdir -p /usr/share/wallpapers

cp -r waybar/scripts ~/.config/waybar/scripts
sudo cp -r wallpapers ~/.config

chmod -R +x ~/.config/waybar/scripts/

sudo pacman -Sy --noconfirm kde-cli-tools
yay -Sy --noconfirm hyprland
yay -Sy --noconfirm waybar-git
yay -Sy --noconfirm hypridle-git
yay -Sy --noconfirm swaylock-effects
sudo pacman -Sy --noconfirm rofi
sudo pacman -Sy --noconfirm gvfs
sudo pacman -Sy --noconfirm thunar thunar-archive-plugin thunar-media-tags-plugin unrar file-roller
sudo pacman -Sy --noconfirm grim slurp wl-clipboard
yay -Sy --noconfirm swww
yay -Sy --noconfirm hyprpicker
sudo pacman -Sy --noconfirm lxsession gnome-disk-utility

cp hypr/hyprland.conf ~/.config/hypr/hyprland.conf
cp hypr/hypridle-1.conf ~/.config/hypr/hypridle-1.conf
cp hypr/hypridle-2.conf ~/.config/hypr/hypridle-2.conf
cp hypr/hypridle-3.conf ~/.config/hypr/hypridle-3.conf
cp hypr/hypridle-4.conf ~/.config/hypr/hypridle-4.conf
cp hypr/hypridle-5.conf ~/.config/hypr/hypridle-5.conf
cp hypr/last_config ~/.config/hypr/last_config
cp waybar/config ~/.config/waybar/config
cp waybar/style.css ~/.config/waybar/style.css
cp rofi/config.rasi ~/.config/rofi/config.rasi
cp rofi/catppuccin.rasi ~/.config/rofi/catppuccin.rasi
cp swaylock/config ~/.config/swaylock/config
cp swww/swww-random.sh ~/.config/swww/swww-random.sh
cp Thunar/uca.xml ~/.config/Thunar/uca.xml
cp alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

chmod +x ~/.config/swww/swww-random.sh
sudo chmod 777 ~/.config/wallpapers

yay -Sy --noconfirm breeze-snow-cursor-theme

mkdir -p ~/.config/gtk-3.0
mkdir -p ~/.config/gtk-4.0
mkdir -p ~/.icons/default
sudo mkdir -p /usr/share/icons/default

cp -r /usr/share/icons/Breeze_Snow ~/.icons/Breeze_Snow

cp gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
cp gtk-3.0/settings.ini ~/.config/gtk-4.0/settings.ini
cp default/index.theme ~/.icons/default/index.theme
sudo cp default/index.theme /usr/share/icons/default/index.theme

gsettings set org.gnome.desktop.interface cursor-theme Breeze_Snow

cat > ~/.bash_profile << EOL
#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
Hyprland
EOL

mkdir -p ~/Screenshots

mkdir -p ~/.config/fish
cp ./fish/config.fish ~/.config/fish/config.fish

chmod +x gui-apps-installer.sh
chmod +x python-installer.sh
chmod +x games-installer.sh

# Clean cache
sudo pacman -Scc --noconfirm
yay -Scc --noconfirm

./gui-apps-installer.sh
