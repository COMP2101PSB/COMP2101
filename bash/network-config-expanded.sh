#!/bin/bash
#
# this script displays some host identification information for a Linux machine
#
# Sample output:
#   Hostname      : zubu
#   LAN Address   : 192.168.2.2
#   LAN Name      : net2-linux
#   External IP   : 1.2.3.4
#   External Name : some.name.from.our.isp

# the LAN info in this script uses a hardcoded interface name of "eno1"
#    - change eno1 to whatever interface you have and want to gather info about in order to test the script

# TASK 1: Dynamically identify the list of interface names for the computer running the script, and use a for loop to generate the report for every interface except loopback

################
# Data Gathering
################
# the first part is run once to get information about the host
# grep is used to filter ip command output so we don't have extra junk in our output
# stream editing with sed and awk are used to extract only the data we want displayed

#####
# Once per host report
#####
# we use the hostname command to get our system name
my_hostname=$(hostname)

# the default route can be found in the route table normally
# the router name is obtained with getent
default_router_address=$(ip r s default| cut -d ' ' -f 3)
default_router_name=$(getent hosts $default_router_address|awk '{print $2}')

# finding external information relies on curl being installed and relies on live internet connection
external_address=$(curl -s icanhazip.com)
external_name=$(getent hosts $external_address | awk '{print $2}')


cat <<EOF
System Identification Summary
=============================
Hostname      : $my_hostname
Default Router: $default_router_address
Router Name   : $default_router_name
External IP   : $external_address
External Name : $external_name
EOF

#####
# End of Once per host report
#####

# the second part of the output generates a per-interface report
# the task is to change this from something that runs once using a fixed value for the interface name to
#   a dynamic list obtained by parsing the interface names out of a network info command like "ip"
#   and using a loop to run this info gathering section for every interface found

# the default version uses a fixed name and puts it in a variable
#####
# Per-interface report
#####
# define the interface being summarized
interface="eno1"

# Find an address and hostname for the interface being summarized
# we are assuming there is only one IPV4 address assigned to this interface
ipv4_address=$(ip a s $interface|awk -F '[/ ]+' '/inet /{print $3}')
ipv4_hostname=$(getent hosts $ipv4_address | awk '{print $2}')

# Identify the network number for this interface and its name if it has one
network_address=$(ip route list dev $interface scope link|cut -d ' ' -f 1)
network_number=$(cut -d / -f 1 <<<"$network_address")
network_name=$(getent networks $network_number|awk '{print $1}')

cat <<EOF
Interface $interface:
===============
Address         : $ipv4_address
Name            : $ipv4_hostname
Network Address : $network_address
Network Name    : $network_name

EOF
#####
# End of per-interface report
#####
