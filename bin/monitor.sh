#!/bin/sh
#

case $1 in
  on)
    xrandr --output eDP-1 --primary --mode 3200x1800 --pos 320x2160 --rotate normal --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --mode 3840x2160 --pos 0x0 --rotate normal
    pactl set-default-sink alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1
    ;;
  
  off)
    xrandr --output eDP-1 --primary --mode 3200x1800 --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --off
    pactl set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo
    ;;

  *)
    if [ -z "`xrandr | grep 'HDMI-2 connected'`" ] ; then
      xrandr --output eDP-1 --primary --mode 3200x1800 --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --off
      pactl set-default-sink alsa_output.pci-0000_00_1b.0.analog-stereo
    else
      xrandr --output eDP-1 --primary --mode 3200x1800 --pos 320x2160 --rotate normal --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --mode 3840x2160 --pos 0x0 --rotate normal
      pactl set-default-sink alsa_output.pci-0000_00_03.0.hdmi-stereo-extra1
    fi
    ;;
esac


