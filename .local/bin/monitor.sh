#!/bin/sh
intern=eDP-1
extern=HDMI-1-0

xrandr --noprimary

if xrandr | grep "$extern disconnected"; then
        xrandr --output "$extern" --off --output "$intern" --auto # Going down to one monitor
else
        xrandr --output "$intern" --output "$extern" --right-of "$intern" --auto # Going up to two monitors
fi
