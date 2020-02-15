#!/bin/sh
# Copyright (C) 2018 Gregory L. Dietsche
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License version 2 as published by the
# Free Software Foundation. This program is distributed in the hope that it
# will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# You should have received a copy of the GNU General Public License along with
# this program. If not, see http://www.gnu.org/licenses/.

# for example allow lan to access Guest
genesis39_forward_zone_to_zone(){
  local rule=$1
  local src_zone=$2
  local dst_zone=$3

  uci -q batch <<-EOT
    set firewall.$rule=forwarding
    set firewall.$rule.src='$src_zone'
    set firewall.$rule.dest='$dst_zone'
EOT
}

#
# Force all DNS traffic in the given zone to this router instead of
# allowing it to go to the DNS server that it was intended for.
#
genesis39_force_zone_dns_to_router(){
  local rule=$1
  local zone=$2
  local ip=$(uci get network.$zone.ipaddr)

  uci -q batch <<-EOT
  set firewall.$rule=redirect
  set firewall.$rule.target='DNAT'
  set firewall.$rule.src='$zone'
  set firewall.$rule.proto='tcp udp'
  set firewall.$rule.src_dport='53'
  set firewall.$rule.dest='$zone'
  set firewall.$rule.dest_ip='$ip'
  set firewall.$rule.name='redirect all $zone dns requests to this router'
EOT
}

#
# Configure the given firewall zone so that NTP traffic sent to this router
# can be answered.
#
genesis39_allow_zone_ntp_to_router(){
  local rule=$1
  local zone=$2
  if [[ "$(uci -q get system.ntp.enable_server)" = "1" ]]; then
    #Allow ntp access because the router is setup as a ntp server
    uci -q batch <<-EOT
      set firewall.$rule=rule
      set firewall.$rule.target='ACCEPT'
      set firewall.$rule.proto='udp'
      set firewall.$rule.src='$zone'
      set firewall.$rule.name='$zone ntp'
      set firewall.$rule.dest_port='123'
EOT
  fi
}

#
# Force all NTP traffic in the given zone to this router instead of
# allowing it to go to the NTP server that it was intended for.
#
genesis39_force_zone_ntp_to_router(){
  local rule=$1
  local zone=$2
  local networkname=$3
  local ip=$(uci get network.$networkname.ipaddr)

  if [[ "$(uci -q get system.ntp.enable_server)" = "1" ]]; then
    # Force all NTP traffic to this router
    uci -q batch <<-EOT
      set firewall.$rule=redirect
      set firewall.$rule.target='DNAT'
      set firewall.$rule.src='$zone'
      set firewall.$rule.proto='udp'
      set firewall.$rule.src_dport='123'
      set firewall.$rule.dest='$zone'
      set firewall.$rule.dest_ip='$ip'
      set firewall.$rule.name='redirect all $zone ntp requests to this router'
EOT
  fi
}

#
# Create a network. Also, setup DHCP and IPv6
genesis39_add_network(){
  local network=$1
  local ip=$2

  uci -q batch <<-EOT
    set network.$network=interface
    set network.$network.type='bridge'
    set network.$network.proto='static'
    set network.$network.ipaddr='$ip'
    set network.$network.netmask='255.255.255.0'

    set dhcp.$network=dhcp
    set dhcp.$network.start='50'
    set dhcp.$network.leasetime='6h'
    set dhcp.$network.limit='200'
    set dhcp.$network.interface=$network

    set dhcp.$network.ra='server'
    set dhcp.$network.dhcpv6='server'
EOT
}

#
# Create a new firewall zone
#
genesis39_add_zone(){
  local rule=$1
  local zone=$2
  local network=$3

  uci -q batch <<-EOT
  set firewall.${rule}_zone=zone
  set firewall.${rule}_zone.input='REJECT'
  set firewall.${rule}_zone.forward='REJECT'
  set firewall.${rule}_zone.output='ACCEPT'
  set firewall.${rule}_zone.name=$zone
  set firewall.${rule}_zone.network=$network
EOT

  uci -q batch <<-EOT
    set firewall.${rule}_fwd_wan=forwarding
    set firewall.${rule}_fwd_wan.src=$zone
    set firewall.${rule}_fwd_wan.dest='wan'
EOT

  uci -q batch <<-EOT
    set firewall.${rule}_accept_dns=rule
    set firewall.${rule}_accept_dns.target='ACCEPT'
    set firewall.${rule}_accept_dns.proto='tcp udp'
    set firewall.${rule}_accept_dns.dest_port='53'
    set firewall.${rule}_accept_dns.src=$zone
    set firewall.${rule}_accept_dns.name='$zone dns'
EOT

  uci -q batch <<-EOT
    set firewall.${rule}_accept_dhcp_four=rule
    set firewall.${rule}_accept_dhcp_four.target='ACCEPT'
    set firewall.${rule}_accept_dhcp_four.proto='udp'
    set firewall.${rule}_accept_dhcp_four.src=$zone
    set firewall.${rule}_accept_dhcp_four.family='ipv4'
    set firewall.${rule}_accept_dhcp_four.dest_port='67'
    set firewall.${rule}_accept_dhcp_four.src_port='68'
    set firewall.${rule}_accept_dhcp_four.name='$zone dhcp4'
EOT

  uci -q batch <<-EOT
    set firewall.${rule}_accept_dhcp_six=rule
    set firewall.${rule}_accept_dhcp_six.target='ACCEPT'
    set firewall.${rule}_accept_dhcp_six.src=$zone
    set firewall.${rule}_accept_dhcp_six.name='$zone dhcp6'
    set firewall.${rule}_accept_dhcp_six.family='ipv6'
    set firewall.${rule}_accept_dhcp_six.dest_port='547'
    set firewall.${rule}_accept_dhcp_six.proto='udp'
    set firewall.${rule}_accept_dhcp_six.src_port='546'
EOT

  uci -q batch <<-EOT
    set firewall.${rule}_accept_icmp_six=rule
    set firewall.${rule}_accept_icmp_six='ACCEPT'
    set firewall.${rule}_accept_icmp_six.family='ipv6'
    set firewall.${rule}_accept_icmp_six.proto='icmp'
    set firewall.${rule}_accept_icmp_six.src='$zone'
    set firewall.${rule}_accept_icmp_six.name='$zone icmp6'
EOT
}
