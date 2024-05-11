#!/bin/sh
BRIGHTNESS_CURRENT=$(/usr/bin/brightnessctl g)
if [[ $BRIGHTNESS_CURRENT -gt 100 ]]; then
  brightnessctl set 5%-
fi
