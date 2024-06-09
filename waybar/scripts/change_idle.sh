#!/bin/bash

CONFIG1=~/.config/hypr/hypridle-1.conf
CONFIG2=~/.config/hypr/hypridle-2.conf
CONFIG3=~/.config/hypr/hypridle-3.conf
CONFIG4=~/.config/hypr/hypridle-4.conf
CONFIG5=~/.config/hypr/hypridle-5.conf
LAST_CONFIG_FILE=~/.config/hypr/last_config

killall hypridle

if [ -f "$LAST_CONFIG_FILE" ]; then
    LAST_CONFIG=$(cat $LAST_CONFIG_FILE)

    if [ "$LAST_CONFIG" = "$CONFIG1" ]; then
        echo "$CONFIG2" > $LAST_CONFIG_FILE
        hypridle -c $CONFIG2 &
    elif [ "$LAST_CONFIG" = "$CONFIG2" ]; then
        echo "$CONFIG3" > $LAST_CONFIG_FILE
        hypridle -c $CONFIG3 &
    elif [ "$LAST_CONFIG" = "$CONFIG3" ]; then
        echo "$CONFIG4" > $LAST_CONFIG_FILE
        hypridle -c $CONFIG4 &
    elif [ "$LAST_CONFIG" = "$CONFIG4" ]; then
        echo "$CONFIG5" > $LAST_CONFIG_FILE
        hypridle -c $CONFIG5 &
    elif [ "$LAST_CONFIG" = "$CONFIG5" ]; then
        echo "$CONFIG1" > $LAST_CONFIG_FILE
        hypridle -c $CONFIG1 &
    fi
else
    echo "$CONFIG1" > $LAST_CONFIG_FILE
    hypridle -c $CONFIG1 &
fi