#!/bin/bash

CONFIG1=~/.config/hypr/hypridle-1.conf
CONFIG2=~/.config/hypr/hypridle-2.conf
CONFIG3=~/.config/hypr/hypridle-3.conf
CONFIG4=~/.config/hypr/hypridle-4.conf
CONFIG5=~/.config/hypr/hypridle-5.conf
LAST_CONFIG_FILE=~/.config/hypr/last_config

sleep 0.3

LAST_CONFIG=$(cat $LAST_CONFIG_FILE)

if [ "$LAST_CONFIG" = "$CONFIG1" ]; then
    echo '{"text": "1", "tooltip": "lock: 0\nsleep: 0"}'
elif [ "$LAST_CONFIG" = "$CONFIG2" ]; then
    echo '{"text": "2", "tooltip": "lock: 10 min\nsleep: 0"}'
elif [ "$LAST_CONFIG" = "$CONFIG3" ]; then
    echo '{"text": "3", "tooltip": "lock: 10 min\nsleep: 30 min"}'
elif [ "$LAST_CONFIG" = "$CONFIG4" ]; then
    echo '{"text": "4", "tooltip": "lock: 20 sec\nsleep: 0"}'
elif [ "$LAST_CONFIG" = "$CONFIG5" ]; then
    echo '{"text": "5", "tooltip": "lock: 20 sec\nsleep: 1 min"}'
fi