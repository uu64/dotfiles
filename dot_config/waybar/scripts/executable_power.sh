#!/bin/bash

entries="Logout\nSuspend\nReboot\nShutdown"

selected=$(echo -e $entries \
    | wofi --width 400 --height 300 --dmenu --cache-file /dev/null --style "$(dirname $0)/power.css" \
    | awk '{print tolower($1)}' \
    )

case $selected in
  logout)
    swaymsg exit;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac