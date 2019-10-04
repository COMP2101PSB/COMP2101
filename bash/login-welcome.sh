#!/bin/bash
#
# This script produces the dynamic welcome message
# it should look like
#   Welcome to planet hostname, title name!

# Improve this script by using the value in the automatic variable $USER for the name
# Improve this script by adding some time and day of the week information to the welcome message
#   Use a format like this:
#   It is HH:MM AM on weekday.

###############
# Variables   #
###############
title="Overlord"
myname="$USER"
hostname=$(hostname)

###############
# Main        #
###############
cow="$(cat <<EOF
Welcome to planet $hostname, "$title $myname!"
EOF
)"

cowsay -f ghostbusters "$cow"
