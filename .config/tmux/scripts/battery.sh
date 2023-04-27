#!/bin/bash

    # If power adapter is present, show lightning bolt
if [ $(cat /sys/class/power_supply/AC/online) == 1 ]
  then
    printf '🗲'
    # If power adapter is not present, show battery, based on charge level
    # Above 30%: show green battery, below 30%: show red battery
elif [ $(cat /sys/class/power_supply/AC/online) == 0 ] && [ $(cat /sys/class/power_supply/BAT0/capacity) -gt 30 ]
  then
    printf '🔋'
    # But if no battery detected, show a power symbol
elif [ -e /sys/class/power_supply/BAT0/capacity ]
  then
    printf '🪫'
else
  printf '⏻'
fi

    # If battery is present, show charge level as a percentage
    # If no battery is present, show nothing
if [ -e /sys/class/power_supply/BAT0/capacity ]
  then
    cat /sys/class/power_supply/BAT0/capacity
    printf '%'
fi
