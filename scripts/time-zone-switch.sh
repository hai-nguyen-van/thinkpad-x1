#! /bin/bash

# Usage: Switches timezone according to online GeoIP position when detected different timezone
#  -f : Forces to switch timezone

# Checks for the Internet and loops otherwise
while ! (ping -c 1 geoip.ubuntu.com 2>&1 >/dev/null) ; do
    sleep 60
done


GEOIP_INFO=`wget -qO - http://geoip.ubuntu.com/lookup`
CURRENT_TZ=`cat /etc/timezone`
LOCATION_TZ=`echo $GEOIP_INFO | sed -n -e 's/.*<TimeZone>\(.*\)<\/TimeZone>.*/\1/p'`
LOCATION_COUNTRY_NAME=`echo $GEOIP_INFO | sed -n -e 's/.*<CountryName>\(.*\)<\/CountryName>.*/\1/p'`
LOCATION_LAT=`echo $GEOIP_INFO | sed -n -e 's/.*<Latitude>\(.*\)<\/Latitude>.*/\1/p'`
LOCATION_LON=`echo $GEOIP_INFO | sed -n -e 's/.*<Longitude>\(.*\)<\/Longitude>.*/\1/p'`
LOCATION_CITY=`echo $GEOIP_INFO | sed -n -e 's/.*<City>\(.*\)<\/City>.*/\1/p'`

# Sets timezone
function set_timezone {
    echo $LOCATION_TZ | sudo tee /etc/timezone
    sudo dpkg-reconfigure --frontend noninteractive tzdata
    DISPLAY=:0.0 XAUTHORITY=~/.Xauthority notify-send -t 30000 -u critical -i stock-alarm \
    "Welcome to $LOCATION_COUNTRY_NAME! New time zone is '$LOCATION_TZ'" \
    "Local time is now:      $(date)
Previous time zone was '$CURRENT_TZ'"
}

# Sets Redshift GPS position
function set_redshift {
    # TODO
    # Change default at startup + change current one
    DISPLAY=:0.0 XAUTHORITY=~/.Xauthority notify-send -t 30000 -u critical -i preferences-desktop-color \
    "Display temperature color" \
    "You are in $LOCATION_CITY, $LOCATION_COUNTRY_NAME.
Redshift is now on coordinates ($LOCATION_LAT, $LOCATION_LON)"
}

case "$1" in
    "-f")
	 set_timezone
	 set_redshift
	 ;;
    *)
	 if [ "$CURRENT_TZ" != "$LOCATION_TZ" ]
	 then
	     set_timezone
	     set_redshift
	 fi
	 ;;
esac
