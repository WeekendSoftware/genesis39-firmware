#!/bin/bash

#
# Quick controls to set the target version and hardware
# Only exporting variables that are required by the build script
#
upstreamVersion=18.06.1
upstreamTarget=ar71xx
export upstreamProfile=archer-c7-v2

# lede|openwrt
export upstreamFaction=openwrt

#
# variables used by the build script
#
export upstreamBuilder=${upstreamFaction}-imagebuilder-${upstreamVersion}-${upstreamTarget}-generic.Linux-x86_64
export upstreamDownload=https://downloads.openwrt.org/releases/${upstreamVersion}/targets/${upstreamTarget}/generic/${upstreamBuilder}.tar.xz

export upstreamSdk=openwrt-sdk-${upstreamVersion}-${upstreamTarget}-generic_gcc-7.3.0_musl.Linux-x86_64
export upstreamSdkDownload=https://downloads.openwrt.org/releases/${upstreamVersion}/targets/${upstreamTarget}/generic/${upstreamSdk}.tar.xz

#make sure LC_TIME is set correctly
export LC_TIME=C

# Publish Settings
export genesis39_publish_packages=/data/ace/greg/tftp/g39/packages/
export genesis39_publish_firmware=/data/ace/greg/tftp/g39/firmware/
export genesis39_secret_key=/home/greg/genesis39/usign-genesis39/usign.genesis39.secret.key

