#!/bin/sh
# Copyright (C) 2017 Gregory L. Dietsche
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License version 2 as published by the
# Free Software Foundation. This program is distributed in the hope that it
# will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# You should have received a copy of the GNU General Public License along with
# this program. If not, see http://www.gnu.org/licenses/.

# for example forward lan Guest
genesis39_forward_zone_to_zone(){
  local $src_zone=$1
  local $dst_zone=$2

  local rule=$(uci add firewall forwarding)
  uci -q batch <<-EOT
    set firewall.$rule.src='$src_zone'
    set firewall.$rule.dest='$dst_zone'
EOT
}

genesis39_force_zone_dns_to_router(){
  local zone=$1
  local ip=$(uci get network.$zone.ipaddr)

  local rule=$(uci add firewall redirect)
  uci -q batch <<-EOT
  set firewall.$rule.target='DNAT'
  set firewall.$rule.src='$zone'
  set firewall.$rule.proto='tcpudp'
  set firewall.$rule.src_dport='53'
  set firewall.$rule.dest='$zone'
  set firewall.$rule.dest_ip='$ip'
  set firewall.$rule.name='redirect all $zone dns requests to this router'
EOT
}

genesis39_force_zone_ntp_to_router(){
  local zone=$1
  local ip=$(uci get network.$zone.ipaddr)

  if [[ "$(uci -q get system.ntp.enable_server)" = "1" ]]; then
    #Allow ntp access because the router is setup as a ntp server
    local rule=$(uci add firewall rule)
    uci -q batch <<-EOT
      set firewall.$rule.target='ACCEPT'
      set firewall.$rule.proto='udp'
      set firewall.$rule.src='$zone'
      set firewall.$rule.name='$zone ntp'
      set firewall.$rule.dest_port='123'
EOT
    # Force all NTP traffic to this router
    rule=$(uci add firewall redirect)
    uci -q batch <<-EOT
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

genesis39_add_zone(){
  local zone=$1
  local network=$2

  local rule=$(uci add firewall zone)
  uci -q batch <<-EOT
  set firewall.$rule.input='REJECT'
  set firewall.$rule.forward='REJECT'
  set firewall.$rule.output='ACCEPT'
  set firewall.$rule.name=$zone
  set firewall.$rule.network=$network
EOT

  rule=$(uci add firewall forwarding)
  uci -q batch <<-EOT
    set firewall.$rule.src=$zone
    set firewall.$rule.dest='wan'
EOT

  rule=$(uci add firewall rule)
  uci -q batch <<-EOT
    set firewall.$rule.target='ACCEPT'
    set firewall.$rule.proto='tcp udp'
    set firewall.$rule.dest_port='53'
    set firewall.$rule.src=$zone
    set firewall.$rule.name='$zone dns'
EOT

  rule=$(uci add firewall rule)
  uci -q batch <<-EOT
    set firewall.$rule.target='ACCEPT'
    set firewall.$rule.proto='udp'
    set firewall.$rule.src=$zone
    set firewall.$rule.family='ipv4'
    set firewall.$rule.dest_port='67'
    set firewall.$rule.src_port='68'
    set firewall.$rule.name='$zone dhcp4'
EOT

  rule=$(uci add firewall rule)
  uci -q batch <<-EOT
    set firewall.$rule.target='ACCEPT'
    set firewall.$rule.src=$zone
    set firewall.$rule.name='$zone dhcp6'
    set firewall.$rule.family='ipv6'
    set firewall.$rule.dest_port='547'
    set firewall.$rule.proto='udp'
    set firewall.$rule.src_port='546'
EOT

  rule=$(uci add firewall rule)
  uci -q batch <<-EOT
    set firewall.$rule.target='ACCEPT'
    set firewall.$rule.family='ipv6'
    set firewall.$rule.proto='icmp'
    set firewall.$rule.src='$zone'
    set firewall.$rule.name='$zone icmp6'
EOT
}
