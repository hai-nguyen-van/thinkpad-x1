#! /bin/bash

function datediff {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    # echo $(( (d1 - d2) / 86400 )) days ≈ $(( ((d1 - d2) / 86400) / 7 )) weeks
    echo $(( (d1 - d2) / 86400 + 1 )) days ≈ $(bc -l <<< "scale=1 ; ((${d1} - ${d2}) / 86400) / 7") weeks
}

function stalk {
    echo -e "FSTTCS 2015 Notification\t\t $(datediff "September 14" "now")"
    echo -e "GEMOC 2015 Workshop     \t\t $(datediff "September 28" "now")"
}

stalk