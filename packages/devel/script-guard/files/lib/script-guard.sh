#!/bin/sh
# Copyright (C) 2020 Gregory L. Dietsche
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU General Public License version 2 as published by the
# Free Software Foundation. This program is distributed in the hope that it
# will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
# of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# You should have received a copy of the GNU General Public License along with
# this program. If not, see http://www.gnu.org/licenses/.

# Call this from the beginning of each script that should run only once
# The first parameter is the uci configuration section
# The second parameter should be something that uniquely identifies your script.
script_guard_begin(){
  local config_section="$1"
  local script_id="$2"
  local result

  config_load "$config_section"
  config_get_bool result guard "$script_id" 0

  if [ "$result" -eq 1  ]; then
    exit 0
  fi
}

#
# Call this at the end of each script that should run only once
# The first parameter is the uci configuration section
# The second parameter should be something that uniquely identifies your script and
# should match the parameter given to script_guard_begin
#
script_guard_end(){
  local config_section="$1"
  local script_id="$2"

  if [ ! -f "/etc/config/$config_section"  ]; then
    touch "/etc/config/$config_section"
  fi

  uci -q set $config_section.guard=script
  uci -q set $config_section.guard.$script_id=1
}

# Call this from the beginning of each script that should run only once.
# This helper funcatino calls both script_guard_begin and script_guard_end
# for you.
# The first parameter is the uci configuration section
# The second parameter should be something that uniquely identifies your script.
script_guard(){
  script_guard_begin "$1" "$2"
  script_guard_end "$1" "$2"
}

