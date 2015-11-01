#! /bin/bash

NEWEST_SC=`find ~/Images/ -maxdepth 1 -type f -printf '%f\n' | grep Screenshot | head -n 1`

if [ -z "$NEWEST_SC" ]
then
    DISPLAY=:0.0 XAUTHORITY=~/.Xauthority notify-send -u critical -i folder-pictures "No recent screenshots to move"
else
    mv "Images/${NEWEST_SC}" Bureau/
    DISPLAY=:0.0 XAUTHORITY=~/.Xauthority notify-send -u critical -i folder-pictures "$NEWEST_SC moved to Desktop"
fi
