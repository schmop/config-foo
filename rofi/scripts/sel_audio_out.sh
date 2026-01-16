#!/bin/bash

if [ $# -eq 0 ]; then

  options=$(pamixer --list-sinks | awk -F " \"" '{ if (NR!=1) { print substr($4, 1, length($4)-1) } }')

  echo "$options"

else

  selected_sink=$(pamixer --list-sinks | grep "$@" | awk '{ print $1 }')
  coproc ( pactl set-default-sink $selected_sink > /dev/null )
  exit 0

fi
