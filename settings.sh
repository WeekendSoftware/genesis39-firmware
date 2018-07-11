#!/bin/bash

#
# Quick controls to set the target version and hardware
# Only exporting variables that are required by the build script
#
upstreamVersion=17.01.4
upstreamVersion=18.06.0-rc1
upstreamTarget=ar71xx
export upstreamProfile=archer-c7-v2

#
# variables used by the build script
#
export upstreamBuilder=openwrt-imagebuilder-${upstreamVersion}-${upstreamTarget}-generic.Linux-x86_64
export upstreamDownload=https://downloads.openwrt.org/releases/${upstreamVersion}/targets/${upstreamTarget}/generic/openwrt-imagebuilder-${upstreamVersion}-${upstreamTarget}-generic.Linux-x86_64.tar.xz
