#!/bin/sh
#

FOCUSED_OUTPUT=`swaymsg -p -t get_outputs | grep focused | cut -d' ' -f2`

case $FOCUSED_OUTPUT in
  "HDMI-A-2")
    pactl set-default-sink alsa_output.pci-0000_00_03.0.hdmi-stereo
    ;;
  
  *)
    pactl set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo
    ;;

esac


