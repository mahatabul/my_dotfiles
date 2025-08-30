#!/usr/bin/env bash

# Path: ~/.config/polybar/docky/scripts/networkmanager_dmenu
# Author: Aditya Shakya (modified for Cinnamon and networkmenu.rasi)

dir="$HOME/.config/polybar/docky/scripts/rofi"
rofi_command="rofi -no-config -theme $dir/networkmenu.rasi"

# NetworkManager CLI commands
nmcli="nmcli -t -f SSID,SIGNAL,ACTIVE,SECURITY dev wifi"

# Options
connect="Connect to Wi-Fi"
disconnect="Disconnect"
enable_wifi="Enable Wi-Fi"
disable_wifi="Disable Wi-Fi"
status="Network Status"

# Get current network status
current=$(nmcli -t -f NAME,TYPE connection show --active | grep wifi | cut -d: -f1)
if [ -n "$current" ]; then
    status_text="Connected: $current"
else
    status_text="Disconnected"
fi

# Variable passed to rofi
options="$connect\n$disconnect\n$enable_wifi\n$disable_wifi\n$status"

chosen="$(echo -e "$options" | $rofi_command -p "Network: $status_text" -dmenu -selected-row 0)"
case $chosen in
    "$connect")
        # List available Wi-Fi networks
        wifi_list=$(nmcli -t -f SSID,SIGNAL,SECURITY dev wifi | awk -F: '{print $1 " (" $2 "%, " $3 ")"}')
        selected=$(echo -e "$wifi_list" | $rofi_command -p "Select Wi-Fi Network" -dmenu)
        if [ -n "$selected" ]; then
            ssid=$(echo "$selected" | awk '{print $1}')
            # Prompt for password if network is secured
            security=$(nmcli -t -f SSID,SECURITY dev wifi | grep "^$ssid:" | cut -d: -f2)
            if [ "$security" != "none" ]; then
                password=$(echo | $rofi_command -p "Enter Password for $ssid" -dmenu)
                nmcli device wifi connect "$ssid" password "$password"
            else
                nmcli device wifi connect "$ssid"
            fi
        fi
        ;;
    "$disconnect")
        nmcli connection down "$current"
        ;;
    "$enable_wifi")
        nmcli radio wifi on
        ;;
    "$disable_wifi")
        nmcli radio wifi off
        ;;
    "$status")
        nmcli device status | $rofi_command -p "Network Status" -dmenu
        ;;
esac
