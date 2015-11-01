#!/bin/bash

# Notify-smart

# Displays a warning notification from hard drive SMART informations
# Aims to be useful at warning asap hard-drive failure risks
# Authors: Hai Nguyen Van, Julien Rouhaud
# Usage: ./notify_smart ( "-h" | "mini-bash" | [DEVICE] ( "-v" | "-l" )? )

# This script requires the `smartctl' command which is available in the `smartmontools' package.
# As well as `notify-send' available in Ubuntu OS

# For a regular usage of this script, you may add the following line in your sudoer configuration file (/etc/sudoers) :
# [username] ALL=NOPASSWD: /usr/sbin/smartctl
# Then use it in your bashrc $PS1 variable in order to get regularly warned in case of problems

DEVICE_PATH="$1"
DEVICE_MODEL=$(sudo smartctl -i ${DEVICE_PATH} | grep "Device Model" | sed 's/[[:print:]]*:[[:space:]][[:space:]][[:space:]][[:space:]][[:space:]]//g')
SMART_CMD="sudo smartctl -a ${DEVICE_PATH}"
SMART_CMD_RETURN_CODE=$(sudo smartctl ${DEVICE_PATH} > /dev/null ; echo $?)
ATTRIBUTES="Reallocated_Sector_Ct | Spin_Retry_Count | End-to-End_Error | Command_Timeout | Reallocated_Event_Count | Current_Pending_Sector | Offline_Uncorrectable"
CONFIG_FILE=~/.notify_smart
ECHO="$(which echo) -e"
yellow=$(tput setaf 3)
green=$(tput setaf 2)
red=$(tput setaf 1)
blue=$(tput setaf 4)
bold=$(tput bold)
reset=$(tput sgr0)

# Show help mode
help_mode () {
    echo "Usage: $0 ([mini-bash] | [-h] | [DEVICE] [-h] [-v])"
    exit 0
}

# Show informations about critical attributes defined in $ATTRIBUTES variable
verbose_mode () {
    RETURN_CODE=$($0 ${DEVICE_PATH} > /dev/null ; echo $?)
    SMARTCTL_OVERALL_RESULT=$(sudo smartctl -H ${DEVICE_PATH} | grep overall-health)
    if ([ ${RETURN_CODE} -eq 0 ])
    then
	echo "SMART status of ${DEVICE_MODEL}: ${bold}${green}PASSED${reset}"
    fi
    if ([ ${RETURN_CODE} -eq 1 ])
    then
	echo "SMART status of ${DEVICE_MODEL}: ${bold}${red}FAILED!${reset}"
    fi
    if ([ ${RETURN_CODE} -eq 2 ])
    then
	echo "SMART status of ${DEVICE_MODEL}: ${bold}${yellow}UNKNOWN${reset}"
    fi

    echo ${SMARTCTL_OVERALL_RESULT}
    echo "Vendor Specific SMART Attributes with Thresholds:"
    echo "ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE"
    ${SMART_CMD} |
    egrep -i "${ATTRIBUTES}"
}

# Shows mini-indicator which is intended to be used in $PS1 variable in bash
mini_bash_mode () {
    for device_path in $(ls /dev/[hs]d[a-z])
    do
	DEVICE=$(echo ${device_path} | cut -d '/' -f 3)
	RETURN_CODE=$($0 ${device_path} > /dev/null ; echo $?)
	SMARTCTL_OVERALL_RESULT=$(sudo smartctl -H ${device_path} | grep overall-health | sed 's/SMART overall-health self-assessment test result: //g')
	DEVICE_MODEL=$(sudo smartctl -i ${device_path} | grep "Device Model" | sed 's/[[:print:]]*:[[:space:]][[:space:]][[:space:]][[:space:]][[:space:]]//g')

	# Set device color to the respective critical degree
	if ([ ${RETURN_CODE} -eq 0 ])
	then
	    SMART_OF_CURRENT_HD="${bold}${green}${DEVICE}${reset}"
	fi
	if ([ ${RETURN_CODE} -eq 1 ])
	then
	    notify-send --urgency=critical -i "error" "SMARTCTL result: ${SMARTCTL_OVERALL_RESULT}" "Possible FAILING hard drive on ${device_path} (${DEVICE_MODEL})" 2> /dev/null
	    if (! [ "${SMARTCTL_OVERALL_RESULT}" = "PASSED" ])
	    then
		# $ECHO "Confirmed FAILING hard drive on ${device_path} (${DEVICE_MODEL}). Drive failure expected in less than 24 hours. SAVE ALL DATA." | wall 2> /dev/null
		notify-send --urgency=critical -i "error" "Drive failure expected in less than 24 hours. SAVE ALL DATA." 2> /dev/null
		notify-send --urgency=critical -i "error" "Drive failure expected in less than 24 hours. SAVE ALL DATA." 2> /dev/null
		notify-send --urgency=critical -i "error" "Drive failure expected in less than 24 hours. SAVE ALL DATA." 2> /dev/null
	    fi
	    $0 ${device_path} -l
	    SMART_OF_CURRENT_HD="${bold}${red}${DEVICE}${reset}"
	fi
	if ([ ${RETURN_CODE} -eq 2 ])
	then
	    SMART_OF_CURRENT_HD="${bold}${yellow}${DEVICE}${reset}"
	fi

	# Underlines if overall-health self-assessment is critical
	if (! [ "${SMARTCTL_OVERALL_RESULT}" = "PASSED" ])
	then
	    SMART_OF_CURRENT_HD="\\e[4m${SMART_OF_CURRENT_HD}\\e[24m"
	fi
	SMART_OF_HDS="${SMART_OF_HDS}${SMART_OF_CURRENT_HD},"

	# Checks for logs
#	$0 ${DEVICE_PATH} -l
done
$(which echo) -e "${SMART_OF_HDS}"
exit 0
}

# Log management
log_mode () {
    # If database log file does not exist or device has not been logged yet
    if (! (grep "${DEVICE_MODEL}" ${CONFIG_FILE} > /dev/null 2> /dev/null))
    then
        # Log the new device
	$0 ${DEVICE_PATH} -v >> ${CONFIG_FILE}
    else
	# Check for attribute values differences
	notify-send -t 60000 --urgency=critical -i "error" "SMART log update on ${DEVICE_MODEL} (${DEVICE_PATH})" "`diff <(egrep -A 9 "${DEVICE_MODEL}" ${CONFIG_FILE}) <($0 ${DEVICE_PATH} -v)`"
	# Remove old entries
	sed -i "/\b\(${DEVICE_MODEL}\)\b/,+8d" ${CONFIG_FILE}
	# Add new entries
	$0 ${DEVICE_PATH} -v >> ${CONFIG_FILE}
    fi
}

# Clears SMART data logged for a device
clear_mode () {
    echo TODO
    exit 0
}

# Returns main final SMART result as bash return code
smart_check_result () {
# 0 : no problem bitch
# 1 : Possible issue !
# 2 : Unknown state, unknown HD SMART information
    if ([ ${SMART_CMD_RETURN_CODE} -ne '0' ])
    then
        # Directly returns 2 if smartctl failed 
	exit 2
    else
	# Checks if all attributes value equal to 0
	for var in $(
	    ${SMART_CMD} |
	    egrep -i "${ATTRIBUTES}" |
	    sed  's/[[:print:]]* [[:space:]] [-] [[:space:]] [[:alnum:]]* [[:space:]]*//g' |
	    cut -d ' ' -f 1
	)
	do
	    if ([ ${var} -ne 0 ]) 
	    then
		exit 1
	    fi
	done
    fi
    # No problem occured, we say okay
    exit 0
}

# Entry-point
if ([ "$1" = "mini-bash" ])
then mini_bash_mode
else
    if ([ "$1" = "-h" ])
    then help_mode
    else
	if ([ "$2" = "-v" ])
	then verbose_mode
	else
	    if ([ "$2" = "-m" ])
	    then mini_verbose_mode
	    else
		if ([ "$2" = "-l" ])
		then log_mode
		fi
	    fi
	fi
    fi
fi

smart_check_result