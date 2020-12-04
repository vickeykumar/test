#!/bin/bash

echo "                 Monitoring battery level";
i=`cat /sys/class/power_supply/BAT0/capacity`
echo "current capacity : $i, " "target capacity : $1"

if [ $i -le $1 ];
then
	notify-send --icon=error "Power Critical";
	paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga;
fi

