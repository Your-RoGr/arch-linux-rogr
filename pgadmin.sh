#!/bin/bash

sudo pacman -Sy --noconfirm python-pipx

sudo mkdir /app
sudo chmod -R 777 /app

pipx install pgadmin4
mkdir -p ~/.local/share/applications/
cp applications/pgadmin4.desktop ~/.local/share/applications/pgadmin4.desktop
cp ~/.local/share/pipx/venvs/pgadmin4/bin/pgadmin4 /app/pgadmin4
cp applications/Postgresql_elephant.png ~/.local/share/applications/Postgresql_elephant.png

pipx ensurepath
