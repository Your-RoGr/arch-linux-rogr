#!/bin/bash

# GUI app's 

mkdir -p ~/.config/Downloads

# --------------------------------------------------------------------------
# Audio & Video & Image
# --------------------------------------------------------------------------

# VLC media player, the open-source multimedia player

# echo "Installing VLC"
# sudo pacman -Sy --noconfirm vlc

# Live stream and record videos

echo "Installing OBS Studio"
sudo pacman -Sy --noconfirm obs-studio

# Free and open source 3D creation suite

echo "Installing Blender"
sudo pacman -Sy --noconfirm blender

# Digital Painting, Creative Freedom

echo "Installing krita"
sudo pacman -Sy --noconfirm krita

# Image viewer

echo "Installing Eye of GNOME"
sudo pacman -Sy --noconfirm eog

echo "Installing imv"
sudo pacman -Sy --noconfirm imv

# --------------------------------------------------------------------------
# Docs
# --------------------------------------------------------------------------

# For pdf edit

echo "Installing LibreOffice"
sudo pacman -Sy --noconfirm libreoffice-still-ru

# Office productivity suite

echo "Installing ONLYOFFICE"
yay -Sy --noconfirm onlyoffice-bin

# --------------------------------------------------------------------------
# Developer Tools
# --------------------------------------------------------------------------

# The Open Source build of Visual Studio Code (vscode) editor

echo "Installing Visual Studio Code"
sudo pacman -Sy --noconfirm code

# Docker with GUI

# echo "Installing Docker desktop"
# yay -Sy --noconfirm docker-desktop
# sudo pacman -Sy --noconfirm docker-compose

# PostgreSQL

echo "Installing PostgreSQL"
sudo pacman -Sy --noconfirm postgresql
sudo -u postgres initdb --locale en_US.UTF-8 -D /var/lib/postgres/data
sudo systemctl start postgresql
sudo systemctl enable postgresql

# PostgreSQL client

# echo "Installing PostBird"
# yay -Sy --noconfirm postbird-bin

# DB Browser for SQLite is a high quality, visual, open source tool to create, design, and edit database files compatible with SQLite.

# echo "Installing DB Browser for SQLite"
# sudo pacman -Sy --noconfirm sqlitebrowser

# Community Python IDE

# echo "Installing Pycharm Community Edition"
# sudo pacman -Sy --noconfirm pycharm-community-edition

# The most intelligent Python IDE

# echo "Installing PyCharm-Professional"
# yay -Sy --noconfirm pycharm-professional

# Easily create 2D and 3D games

# echo "Installing Godot Engine"
# sudo pacman -Sy --noconfirm godot

# Godot (C#/.NET)

# echo "Installing Godot (C#/.NET)"
# yay -Sy --noconfirm godot-mono-bin

# --------------------------------------------------------------------------
# Networking
# --------------------------------------------------------------------------

# Discord desktop app via browser

echo "Installing WebCord"
yay -S --noconfirm webcord

# Telegram

echo "Installing telegram-desktop"
sudo pacman -Sy --noconfirm telegram-desktop

# The web browser from Yandex

echo "Installing Yandex Browser"
yay -Sy --noconfirm yandex-browser

echo "Installing Google Chrome"
yay -Sy --noconfirm google-chrome

echo "Installing Firefox"
sudo pacman -Sy --noconfirm firefox

# --------------------------------------------------------------------------
# Utilities
# --------------------------------------------------------------------------

# Markdown-based knowledge base

echo "Installing Obsidian"
sudo pacman -Sy --noconfirm obsidian

# Read e-books

echo "Installing evince"
sudo pacman -Sy --noconfirm evince

# Fast and reliable FTP client

echo "Installing FileZilla"
sudo pacman -Sy --noconfirm filezilla

# --------------------------------------------------------------------------
# Install other gui app's 
# --------------------------------------------------------------------------

echo "Installing gnome-clocks"
sudo pacman -Sy --noconfirm gnome-clocks

echo "Installing Filelight"
sudo pacman -S --noconfirm filelight

# BitTorrent client
sudo pacman -S --noconfirm qbittorrent

# Clean cache
sudo pacman -Scc --noconfirm
yay -Scc --noconfirm

./games-installer.sh
