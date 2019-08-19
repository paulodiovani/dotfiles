#!/bin/sh
#   pulsevol.sh
#   PulseAudio Volume Control Script
#   Original 2010-05-20 - Gary Hetzel <garyhetzel@gmail.com>
#      
#   Modified 2010-10-18 by Fisslefink <fisslefink@gmail.com>
#    - Added support for multiple sinks and Ubuntu libnotify OSD
#
#   Usage:  pulsevol.sh [sink_index] [up|down|min|max|overmax|toggle|mute|unmute]
#

EXPECTED_ARGS=2
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
then
    echo "Usage: `basename $0` [sink_index] [up|down|min|max|overmax|toggle|mute|unmute]"
    exit $E_BADARGS
fi

SINK=$1
STEP=5
MAXVOL=65537 # let's just assume this is the same all over
OVERMAX=130  # how much the volume can raise over 100%
#MAXVOL=`pacmd list-sinks | grep "volume steps" | cut -d: -f2 | tr -d "[:space:]"`

if [ "$SINK" = "first" ] 
then
    SINK=`pacmd list-sinks | grep index | head -n1 | cut -d: -f2 | tr -d "[:space:]"`
fi

getperc(){
    VOLPERC=`pacmd list-sinks | grep "volume" | head -n1 | cut -d: -f3 | cut -d% -f1 | tr -d "[:space:]"`
}

getperc;

up(){
    VOLSTEP="$(( $VOLPERC+$STEP ))";
}

down(){
    VOLSTEP="$(( $VOLPERC-$STEP ))";
}

max(){
    pacmd set-sink-volume $SINK $MAXVOL > /dev/null
}

min(){
    pacmd set-sink-volume $SINK 0 > /dev/null
}

overmax(){
    SKIPOVERCHECK=1
    if [ $VOLPERC -lt 100 ]; then
        max;
        exit 0;
    fi
    up
}

mute(){
    pacmd set-sink-mute $SINK 1 > /dev/null
    notify-send " " -i "notification-audio-volume-muted" -h int:value:0 -h string:synchronous:volume
}

unmute(){
    VOLSTEP="$(( $VOLPERC-0 ))";
    SKIPOVERCHECK=1
    pacmd set-sink-mute $SINK 0 > /dev/null
}

toggle(){
    M=`pacmd list-sinks | grep "muted" | cut -d: -f2 | tr -d "[:space:]"`
    if [ "$M" = "no" ]; then
        mute
        exit 0;
    else
        unmute;
    fi
}

case $2 in
up)
    up;;
down)
    down;;
max)
    max
    exit 0;;
min)
    min
    exit 0;;
overmax)
    overmax;;
toggle)
    toggle;;
mute)
    mute;
    exit 0;;
unmute)
    unmute;;
*)
    echo "Usage: `basename $0` [sink_index] [up|down|min|max|overmax|toggle|mute|unmute]"
    exit 1;;
esac

VOLUME="$(( ($MAXVOL/100) * $VOLSTEP ))"
MAXCHECK="$(( $MAXVOL * $OVERMAX / 100  ))"

if [ -z $SKIPOVERCHECK ]; then
    if [ $VOLUME -gt $MAXCHECK ]; then
        VOLUME=$MAXCHECK
    elif [ $VOLUME -lt 0 ]; then
        VOLUME=0
    fi
fi

pacmd set-sink-volume $SINK $VOLUME > /dev/null

VOLPERC=`pacmd list-sinks | grep "volume" | head -n1 | cut -d: -f3 | cut -d% -f1 | tr -d "[:space:]"`
VOLPERC="$(( $VOLPERC * 100 / $OVERMAX))"

if [ "$VOLPERC" = "0" ]; then
        icon_name="notification-audio-volume-off"
    else
        if [ "$VOLPERC" -lt "33" ]; then
            icon_name="notification-audio-volume-low"
        else
            if [ "$VOLPERC" -lt "67" ]; then
                icon_name="notification-audio-volume-medium"
            else
                icon_name="notification-audio-volume-high"
            fi
        fi
fi

notify-send " " -i $icon_name -h int:value:$VOLPERC -h string:synchronous:volume
