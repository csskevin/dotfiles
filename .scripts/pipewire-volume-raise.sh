#!/bin/sh
#SINK_VOLUME_CURRENT=$(pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' )
#if [[ $SINK_VOLUME_CURRENT -lt 100 ]]; then
pactl set-sink-volume @DEFAULT_SINK@ +1%
#fi

