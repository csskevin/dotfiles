#!/bin/bash

current_sink=$(pactl get-default-sink)
sinks_to_search=(
  pci-0000_00_1f
  usb-Kingston_HyperX_Virtual_Surround_Sound
)
sinks=()
for sink in "${sinks_to_search[@]}"; do
  entry=$(pactl list sinks | grep "Name: alsa_output" | grep $sink | sed -e "s/^.*Name: //")
  sinks+=($entry)
done

sinks_length="${#sinks[@]}"
index=0
selected_index=0
for sink in "${sinks[@]}"; do
  if [[ "$sink" == "$current_sink" ]]; then
    selected_index=$index
  fi
  index=$((index + 1))
done
new_index=$(( (selected_index + 1) % sinks_length ))
pactl set-default-sink "${sinks[new_index]}"
