#! /bin/bash

# TODO: automatically compute threshold

function alert (){
    DISPLAY=:0.0 XAUTHORITY=~/.Xauthority \
	 notify-send \
	 -u critical \
	 -i media-optical-dvd \
	 "WARNING! SWAP CRITICAL" "Virtual memory used: $1 kB\nIdle memory: $2 kB\nMemory swapped in from disk: $3 kB/s\nMemory swapped to disk: $4 kB/s"
}

function safe_free {
    (/home/psaxl/code/thinkpad-x1/scripts/drafts/gnome-panel-reset.sh >/dev/null 2>/dev/null) &
}

function rude_free {
    # TODO
    return 0
}

while read line
do
    read mem_swpd mem_free swap_si swap_so <<< $(echo $line | awk '{print $3,$4,$7,$8}' OFS=' ' | grep -E "[0-9]+")
    # echo VERBOSE: $mem_swpd $mem_free $swap_si $swap_so
    
    # Tentative 1. Recharger GNOME Panel
    # Tentative 2. Tuer le processus prenant le plus de place
    if [ -n "$mem_swpd" ] && { [ -n "$mem_free" ]; } 
    then
	 if [[ "$mem_swpd" -ge 3700000 || ("$mem_free" -le 110000 && ("$swap_so" -gt 0 )) ]]
	 then
	     alert $mem_swpd $mem_free $swap_si $swap_so
	     safe_free
	 fi
    fi
done < <(vmstat 5)

# Test case
# procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
#  r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
#  0  0 3632736 149312   1268 497524  982 28430  8047 28505 13169 6353 28  7 55 10
#  0  0 3779984 160316   2404 483952  514 31482  1748 31568 10243 5575 26  7 65  3
#  4  0 3982796 150400   2440 489748 1473 41564  5602 41585 13060 6050 27  6 63  3
#  1  1 3997664 114284  19484 497204 1212 6293  9686  6390 7643 11245 23  6 51 20
#  3  0 3996044 174208   2316 488556 11495 4853 19462  5041 9857 7610 31  6 48 15
#  2  1 3997692 117428  11608 506780 1140  812  7862   834 5941 10694 42  5 51  1
#  2  4 3997432 107752   2612 460732 1107  266  6730   453 7898 25392 81  8  8  3
#  1 16 3997688 100880   1912 434424 9011 2738 88810  3668 13751 13321 42 13  7 38
#  0 10 3997692 101560    584 431076  293  193 36658   474 4587 5437  7  4  0 89
#  1 11 3997692 100808   2372 432704  390  203 42315   533 4184 4825  2  6  2 90
