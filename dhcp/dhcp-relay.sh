# Himmel Heiter

#!/bin/bash

apt update

apt-get install isc-dhcp-relay rsyslog -y

echo "# Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS=\"10.74.14.150\"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES=\"eth0 eth1 eth2\"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=\"\"" >/etc/default/isc-dhcp-relay

service rsyslog start

echo "net.ipv4.ip_forward=1" > /etc/sysctl.conf

service isc-dhcp-relay restart
service isc-dhcp-relay status
