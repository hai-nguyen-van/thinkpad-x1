#! /bin/bash

# Error message received on stderr from [gnome-panel --replace] :
# ** (gnome-panel:3716): WARNING **: Failed to load applet IndicatorAppletCompleteFactory::IndicatorAppletComplete:
# GDBus.Error:org.freedesktop.DBus.Error.NoReply: Message did not receive a reply (timeout by message bus)

INDICATOR_APPLET_COMPLETE_PID=`ps ax | grep "indicator-applet-complete" | head -n 1 | sed -e 's/^[ \t]*//' | cut -d ' ' -f 1`

DISPLAY=:0.0 XAUTHORITY=~/.Xauthority notify-send -i preferences-desktop-notification "Restarting GNOME Panel..." "Process $INDICATOR_APPLET_COMPLETE_PID will be killed"
gnome-panel --replace 2> /tmp/gnome-panel-error.log &
while inotifywait -t 10 -e close_write,modify /tmp/gnome-panel-error.log
do
    if (grep "Failed to load applet IndicatorAppletCompleteFactory::IndicatorAppletComplete:" /tmp/gnome-panel-error.log)
    then
	 $0 &
	 break
    fi
done

#### DIRTY SOLUTION ####
# gnome-panel --replace 2> /tmp/gnome-panel-error.log &
# sleep 1
# if (grep "Failed to load applet IndicatorAppletCompleteFactory::IndicatorAppletComplete:" /tmp/gnome-panel-error.log > /dev/null)
# then
#     rm -f /tmp/gnome-panel-error.log
#     $0
# fi
