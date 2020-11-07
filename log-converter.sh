#!/usr/bin/env bash

#
# FFXIV ACT Log Reader
#
# Description:
#   Filter and convert ACT log output to show chatlogs only
#
# Usage:
#   log-converter.sh [FILE]...
#
# Requirements:
#   - FFXIV (duh)
#   - AdvancedCombatTracker
#   - ripgrep

# Name of folder to output converted files to
DESTINATION="output"

mkdir -p "$DESTINATION"

# Set list of codes and corresponding channel names
declare -A channels
channels=(
    ["000a"]="Local"
    ["001."]="Emotes"
    ["000e|."]="Party|"
    ["0025"]="CWLS1"
    ["000[cd]"]="Whisper"
    ["0044"]="NPC"
    ["0039"]="System"
)


fixnames() {
    # Replace channel codes with names from array
    TEMP2="$1"
    for code in "${!channels[@]}"
    do
        CHANNEL=${channels[$code]}
        TEMP2=$(echo "$TEMP2" | sed "s/$code/$CHANNEL/g")
    done
}


convert() {
    INPUT=$1
    OUTPUT=$2

    echo -e "\nProcessing ${INPUT}"

    # Get only chat logs (ignore combat logs)
    TEMP1=$(rg '.*\|00.*\|' $INPUT |\
    # Filter to timestamp,channel,user,message
    cut -d'|' -f 2-5 |\
    # Trim down timestamps
    sed 's/\.0000000+00:00//g')

    fixnames "$TEMP1"

    # Clean up presentation
    echo "$TEMP2" | sed 's/|/ | /g' > "${DESTINATION}/${OUTPUT}"

    echo -e "Saved to:\n    ${DESTINATION}/${OUTPUT}"
}


if [ -z $1 ]
then
    # If no argument is given, convert all files
    echo "No argument specified, converting all files..."
    for f in *.log
    do
        FILENAME=$(echo ${f%.*} | sed 's/Network_//').txt
        convert $f "$FILENAME"
    done
else
    # If arguments are given, convert only those files
    for f in "$@"
    do
        FILENAME=$(echo ${f%.*} | sed 's/Network_//').txt
        convert $f "$FILENAME"
    done
fi
