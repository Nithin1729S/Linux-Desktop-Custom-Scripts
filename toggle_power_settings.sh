#!/bin/bash

STATE_FILE="$HOME/.toggle_power_settings_state"

strip_uint32() {
    echo "$1" | sed 's/^uint32 //'
}

if [ ! -f "$STATE_FILE" ]; then
    {
        gsettings get org.gnome.settings-daemon.plugins.power idle-dim
        gsettings get org.gnome.desktop.session idle-delay
        gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type
        gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type
        gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout
        gsettings get org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout
    } > "$STATE_FILE"

    gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
    gsettings set org.gnome.desktop.session idle-delay 0
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0

    notify-send "Top Performance Mode Activated"

else
    mapfile -t settings < "$STATE_FILE"

    ORIGINAL_IDLE_DIM="${settings[0]}"
    ORIGINAL_IDLE_DELAY=$(strip_uint32 "${settings[1]}")
    ORIGINAL_AC_TYPE="${settings[2]}"
    ORIGINAL_BATTERY_TYPE="${settings[3]}"
    ORIGINAL_AC_TIMEOUT=$(strip_uint32 "${settings[4]}")
    ORIGINAL_BATTERY_TIMEOUT=$(strip_uint32 "${settings[5]}")

    gsettings set org.gnome.settings-daemon.plugins.power idle-dim $ORIGINAL_IDLE_DIM
    gsettings set org.gnome.desktop.session idle-delay $ORIGINAL_IDLE_DELAY
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type $ORIGINAL_AC_TYPE
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type $ORIGINAL_BATTERY_TYPE
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout $ORIGINAL_AC_TIMEOUT
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout $ORIGINAL_BATTERY_TIMEOUT

    rm "$STATE_FILE"

    notify-send "Normal Mode Activated"
fi
