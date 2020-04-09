#!/bin/bash

#
# Quick controls to set the target version and hardware
# Only exporting variables that are required by the build script
#
upstreamVersion=19.07.2
upstreamTarget=ath79
export upstreamProfile=tplink_archer-a7-v5

# lede|openwrt
export upstreamFaction=openwrt

#
# variables used by the build script
#
export upstreamBuilder=${upstreamFaction}-imagebuilder-${upstreamVersion}-${upstreamTarget}-generic.Linux-x86_64
export upstreamDownload=https://downloads.openwrt.org/releases/${upstreamVersion}/targets/${upstreamTarget}/generic/${upstreamBuilder}.tar.xz

export upstreamSdk=openwrt-sdk-${upstreamVersion}-${upstreamTarget}-generic_gcc-7.5.0_musl.Linux-x86_64
export upstreamSdkDownload=https://downloads.openwrt.org/releases/${upstreamVersion}/targets/${upstreamTarget}/generic/${upstreamSdk}.tar.xz

#make sure LC_TIME is set correctly
export LC_TIME=C

# Publish Settings
export genesis39_publish_packages=/data/ace/greg/tftp/g39/packages/
export genesis39_publish_firmware=/data/ace/greg/tftp/g39/firmware/
export genesis39_secret_key=/home/greg/genesis39/usign-genesis39/usign.genesis39.secret.key

