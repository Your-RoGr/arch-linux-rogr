#!/bin/bash

sudo pacman -Sy --noconfirm steam
yay -Sy --noconfirm portproton
yay -Sy --noconfirm protonup-qt

# Clean cache
sudo pacman -Scc --noconfirm
yay -Scc --noconfirm

sudo reboot
