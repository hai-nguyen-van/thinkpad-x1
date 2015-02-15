#! /bin/bash

# Opens a SSH tunnel with google-chrome on it
# Usage: ./tunnel_ssh_make.ssh [ (open)? | close ]

# open : opens a SSH tunnel then a Google Chrome process through it
# close : closes all SSH tunnels

is_busy () {
    BUSY_PORTS_ON_LOCALHOST=$(nmap localhost | grep tcp | cut -d '/' -f 1)
    if [[ $BUSY_PORTS_ON_LOCALHOST == *"$1"* ]]
    then 
	 exit 1
    else
	 exit 0
    fi
}

# Random server choice (TBD)
choose_server () {
    CHOSEN_SERVER="zamok" #default, but to be changed randomly
    echo ${CHOSEN_SERVER}
}

# Random port allocation (TBD)
allocate_port () {
    CHOSEN_PORT="9999" #default, but to be changed randomly
    echo ${CHOSEN_PORT}
}

SSH_SERVER=$(choose_server)
ALLOCATED_PORT=$(allocate_port)
BROWSER="google-chrome"

# "close" case
if [[ $1 == "close" ]]
then
    TUNNEL_PROCESSES=$(ps ax | grep "ssh -ND" | sed -e 's/^[ \t]*//' | cut -d ' ' -f 1)
    for proc in ${TUNNEL_PROCESSES} ; do kill ${proc} 2> /dev/null ; done
    exit 0
fi

# Port opening failure
if (! (is_busy $(allocate_port)))
then
    echo "Failed to open SSH tunnel: Port ${ALLOCATED_PORT} is already assigned. Close SSH tunnel instances then retry."
    exit 1
fi

open_chromium_instance () {
    ssh -ND ${ALLOCATED_PORT} ${SSH_SERVER} &
    ${BROWSER} --proxy-server="socks5://localhost:${ALLOCATED_PORT} ; http=localhost:${ALLOCATED_PORT}" > /dev/null 2> /dev/null &
}

# Default, "open" case
if [[ $1 == "open" ]] || [ -z "$VAR" ]
then
    echo "Port ${ALLOCATED_PORT} is free. Establishing connection with ${SSH_SERVER}..."
    open_chromium_instance
else
    echo "Unknown argument"
    exit 2
fi