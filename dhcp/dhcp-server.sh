# Revolte

#!/bin/bash

echo "nameserver 192.168.122.1" >/etc/resolv.conf

apt update
apt install isc-dhcp-server rsyslog -y

echo "# Defaults for isc-dhcp-server (sourced by /etc/init.d/isc-dhcp-server)
# Path to dhcpd's config file (default: /etc/dhcp/dhcpd.conf).
#DHCPDv4_CONF=/etc/dhcp/dhcpd.conf
#DHCPDv6_CONF=/etc/dhcp/dhcpd6.conf
# Path to dhcpd's PID file (default: /var/run/dhcpd.pid).
#DHCPDv4_PID=/var/run/dhcpd.pid
#DHCPDv6_PID=/var/run/dhcpd6.pid
# Additional options to start dhcpd with.
#       Don't use options -cf or -pf here; use DHCPD_CONF/ DHCPD_PID instead
#OPTIONS=\"\"
# On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
#       Separate multiple interfaces with spaces, e.g. \"eth0 eth1\".
INTERFACESv4=\"eth0\"
INTERFACESv6=\"\"" >/etc/default/isc-dhcp-server

echo "
# Subnet A1
subnet 10.74.14.128 netmask 255.255.255.252 {
}

# Subnet A2
subnet 10.74.0.0 netmask 255.255.248.0 {
    range 10.74.0.2 10.74.7.254;
    option routers 10.74.0.1;
    option broadcast-address 10.74.7.255;
    option domain-name-servers 10.74.14.146;
    default-lease-time 720;
    max-lease-time 5760;
}

# Subnet A3
subnet 10.74.8.0 netmask 255.255.252.0 {
    range 10.74.8.3 10.74.11.254;
    option routers 10.74.8.1;
    option broadcast-address 10.74.11.255;
    option domain-name-servers 10.74.14.146;
    default-lease-time 720;
    max-lease-time 5760;
}

# Subnet A4
subnet 10.74.14.132 netmask 255.255.255.252 {
}

# Subnet A5
subnet 10.74.14.136 netmask 255.255.255.252 {
}

# Subnet A6
subnet 10.74.14.140 netmask 255.255.255.252 {
}

# Subnet A7
subnet 10.74.12.0 netmask 255.255.254.0 {
    range 10.74.12.2 10.74.13.254;
    option routers 10.74.12.1;
    option broadcast-address 10.74.13.255;
    option domain-name-servers 10.74.14.146;
    default-lease-time 720;
    max-lease-time 5760;
}

# Subnet A8
subnet 10.74.14.0 netmask 255.255.255.128 {
    range 10.74.14.3 10.74.14.126;
    option routers 10.74.14.1;
    option broadcast-address 10.74.14.127;
    option domain-name-servers 10.74.14.146;
    default-lease-time 720;
    max-lease-time 5760;
}

# Subnet A9
subnet 10.74.14.144 netmask 255.255.255.252 {
}

# Subnet A10
subnet 10.74.14.148 netmask 255.255.255.252 {
}
" >/etc/dhcp/dhcpd.conf

rm /var/run/dhcpd.pid

service isc-dhcp-server restart
service rsyslog start

service isc-dhcp-server status
