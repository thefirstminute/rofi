#!/usr/bin/env bash

ROFI_CMD="${ROFI_CMD:-rofi -dmenu -i}"

entries="Log Out\nReboot\nShutdown\nSleep"

declare -A commands=(
    ["Log Out"]=sys_logout
    ["Reboot"]=sys_reboot
    ["Shutdown"]=sys_shutdown
    ["Sleep"]=sys_sleep
)

confirm_action() {
    local choice
    choice=$(echo -e "Yes\nNo" |\
        rofi -p "Are you sure?" -dmenu -a 0 -u 1 -selected-row 1)

    if [ "$choice" == "Yes" ]; then
        echo "$choice"
    fi
}

sys_logout() { dm-tool switch-to-greeter; }
sys_reboot() { [ "$(confirm_action)" = "Yes" ] && poweroff --reboot; }
sys_shutdown() { [ "$(confirm_action)" = "Yes" ] && poweroff; }
sys_sleep() { systemctl suspend; }

while choice=$(echo -en "$entries" | $ROFI_CMD -p "Session"); do
    ${commands[$choice]};
    exit 0
done

exit 1
