#!/bin/sh
#

case $1 in
  on)
    xrandr --output eDP-1 --primary --mode 3200x1800 --pos 320x2160 --rotate normal --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --mode 3840x2160 --pos 0x0 --rotate normal
    ;;
  
  off)
    xrandr --output eDP-1 --primary --mode 3200x1800 --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --off
    ;;

  *)
    if [ -z "`xrandr | grep 'HDMI-2 connected'`" ] ; then
      xrandr --output eDP-1 --primary --mode 3200x1800 --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --off
    else
      xrandr --output eDP-1 --primary --mode 3200x1800 --pos 320x2160 --rotate normal --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --mode 3840x2160 --pos 0x0 --rotate normal
    fi
    ;;
esac


