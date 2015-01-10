#!/bin/bash

# RATP bus stop time
# Hai Nguyen Van <nguyenva@informatique.univ-paris-diderot.fr>

# Usage: ./next_ratp_bus.sh [-a]
# -a : Print the result on the libnotify/notify-osd notification service

# To change the configuration of this app, you need to retrieve RATP_URL by entering your desired location in the following link then get back the new link
# http://www.ratp.fr/horaires/fr/ratp/bus

# Current configuration
# --------------------------
RATP_BUS_NO="187"
RATP_STOP_NAME="Div. Leclerc Camille Desmoulins"
RATP_DIRECTION="Porte d'Orleans"
RATP_URL="http://www.ratp.fr/horaires/fr/ratp/bus/prochains_passages/PP/B187/187_598_601/R"

_ALERT_IMG_LOC_="/home/psaxl/code/scripts/images/ratp.png"

# testing internet connection
if (! (ping -c 1 google.com > /dev/null 2> /dev/null))
then echo "Failed to fetch: no available Internet connection" ; exit 1
fi

rm -f /tmp/_bus_time* 2> /dev/null
wget -O /tmp/_bus_time.html $RATP_URL  > /dev/null 2>/dev/null
_WEB_RES_=$(cat /tmp/_bus_time.html | grep "${RATP_DIRECTION}" | cut -d '>' -f 4 | cut -d ' ' -f 1)
TIME1=$(echo ${_WEB_RES_} | cut -d ' ' -f 1)
TIME2=$(echo ${_WEB_RES_} | cut -d ' ' -f 2)

if [ $# = 1 ]
then
    DISPLAY=:0.0 XAUTHORITY=~/.Xauthority notify-send -u critical -i "${_ALERT_IMG_LOC_}" "Next stops in ${TIME1} min and ${TIME2} min at ${RATP_STOP_NAME}"
else
    echo "Next stops in ${TIME1} min and ${TIME2} min at ${RATP_STOP_NAME}"
fi
rm -f /tmp/_bus_time* 2> /dev/null

exit 0