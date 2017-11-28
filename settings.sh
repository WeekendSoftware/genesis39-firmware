#!/bin/bash

#
# Quick controls to set the target version and hardware
# Only exporting variables that are required by the build script
#
ledeVersion=17.01.4
ledeTarget=ar71xx
export ledeProfile=archer-c7-v2

#
# variables used by the build script
#
export ledeBuilder=lede-imagebuilder-${ledeVersion}-${ledeTarget}-generic.Linux-x86_64
export ledeDownload=https://downloads.lede-project.org/releases/${ledeVersion}/targets/${ledeTarget}/generic/lede-imagebuilder-${ledeVersion}-${ledeTarget}-generic.Linux-x86_64.tar.xz
