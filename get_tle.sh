#!/bin/bash

# SPACE-TRACK TLE online fetcher
# <https://www.space-track.org/documentation#/tle>
# Hai Nguyen Van <nguyenva@informatique.univ-paris-diderot.fr>
# Institut de Physique du Globe de Paris, Université Paris Diderot, France

# Usage: ./get_tle.sh [USERNAME] [PASSWORD] [TWO-LINE or THREE-LINE] [SAT ID or NAME]

# testing internet connection
if (! (ping -c 1 google.com > /dev/null 2> /dev/null))
then echo "Failed to fetch: no available Internet connection" ; exit 1
fi

rm -f /tmp/catalog* 2> /dev/null

if [[ $3 = 2 ]]
then _URL_="https://www.space-track.org/perl/dl.pl?ID=1" ; _IS_THREE_=0
else _URL_="https://www.space-track.org/perl/dl.pl?ID=2" ; _IS_THREE_=1
fi

echo -n "Fetching data from space-track.org..."
wget --no-check-certificate --save-cookies /tmp/cookies_space_track.txt "https://www.space-track.org/perl/login.pl?username=$1&password=$2&_submitted=1"  > /dev/null 2>/dev/null
wget --no-check-certificate -O /tmp/catalog_space_track.txt.gz --load-cookies /tmp/cookies_space_track.txt $_URL_  > /dev/null 2>/dev/null
gzip -Ndf /tmp/catalog_space_track.txt.gz > /dev/null 2>/dev/null
_FILE_NAME_=`ls /tmp/catalog*.txt`

echo -e "\rTLE fetched from: $_FILE_NAME_"
for i in `cat $_FILE_NAME_ | grep -i -n "$4" | cut -d ':' -f 1`
do
    let _VAR_CNT_2=$i+1+$_IS_THREE_
    let _LINES_=2+$_IS_THREE_
    
    # display output
    head -n $_VAR_CNT_2 $_FILE_NAME_ | tail -n $_LINES_

done

rm -f *login.pl*
rm -f *catalog*

exit 0