#!/bin/bash
#
# this script displays some host identification information for a simple Linux machine
#
# Sample output:
#   Hostname        : hostname
#   LAN Address     : 192.168.2.2
#   LAN Hostname    : host-name-from-hosts-file
#   External IP     : 1.2.3.4
#   External Name   : some.name.from.our.isp

# Task 1: Add a section to the script to define variables which hold the output data for
#         each output item and move the commands which generate the data to that section so that
#         the output command only outputs the labels and single variables.

# Task 2: Add output items for the default router's name and IP address,
#         adding a name to your /etc/hosts file as needed.
# e.g.
#   Router Address  : 192.168.2.1
#   Router Hostname : router-name-from-hosts-file

# Task 3: Add output items for the network's name and IP address, adding a name to your /etc/networks file as needed.
# e.g.
#   Network Number. : 192.168.2.0
#   Network Name    : network-name-from-networks-file

# we use the hostname command to get our system name
# the LAN name is looked up using the LAN address in case it is different from the system name
# finding external information relies on curl being installed and relies on live internet connection
# awk is used to extract only the data we want displayed from the commands which produce extra data
# this command is ugly done this way, so generating the output data into variables is recommended to make the script more readable.
# e.g.
#   interface_name=$(ip a |awk '/: e/{gsub(/:/,"");print $2}')

MyHostname=$(hostname)
Interface=$(ip a |awk '/: e/{gsub(/:/,"");print $2}')
LanAddress=$(ip a s $Interface|awk '/inet /{gsub(/\/.*/,"");print $2}')
LanHostname=$(getent hosts $LanAddress| awk '{print $2}')
ExternalIpAddress=$(curl -s icanhazip.com)
ExternalName=$(getent hosts $ExternalIpAddress | awk '{print $2}')
RouterAddress=$(ip route show | grep -i 'default via'| awk '{print $3 }')
RouterName=$(head -1 /etc/hosts | awk '{print $2}')
NetworkAddress=$(tail -1  /etc/networks | awk '{print $2}')
NetworkName=$(tail -1  /etc/networks | awk '{print $1}')

cat <<EOF
Hostname              : $MyHostname
LAN Address           : $LanAddress
LAN Hostname          : $LanHostname
External IP Address   : $ExternalIpAddress
External Name         : $ExternalName
Router Address        : $RouterAddress
Router Name           : $RouterName
Network Address       : $NetworkAddress
Network Name          : $NetworkName
EOF
