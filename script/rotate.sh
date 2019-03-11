#!/bin/bash

# rotate.sh V0.6 190311 qrt@qland.de
# linux bash script for rotation control (display + touchscreen + optional pen)

# make script executable
# chmod a+x rotate.sh

# open a console and enter
# $ xinput -list
# note the input device(s) you want to rotate
#if unused -> DEVICE1=
DEVICE0="ELAN22A6:00 04F3:22A6"                     # Asus T102HA touchscreen
DEVICE1="ELAN22A6:00 04F3:22A6 Pen Pen (0)"         #             pen
DEVICE2="ASUS HID Device ASUS HID Device Touchpad"  #             touchpad

# display rotation might set brighness to maximum
# bright.sh must be executable in same directory (if set to true)
#
RESTBRIGHT=true                         # restore brightness

ORIA0=(normal left inverted right)      # orientation array 0
ORIA1='(normal|left|inverted|right)'    #                   1

CUDIS=`xrandr --current | grep primary | sed -e 's/ .*//g'` # current display
CUORI=`xrandr --current --verbose | grep primary | egrep -o '\) '$ORIA1' \(' | egrep -o $ORIA1` # current orientation

path=`dirname $0`                       # arguments
file="$path/rotate.dat"
arg1="$1"

#-------------------------------------------------------------------------------

function do_rotate
{
  xrandr --output $1 --rotate $2

  TRANSFORM='Coordinate Transformation Matrix'
  case "$2" in
    normal)
      [ ! -z "$DEVICE0" ] && xinput set-prop "$DEVICE0" "$TRANSFORM" 1 0 0 0 1 0 0 0 1
      [ ! -z "$DEVICE1" ] && xinput set-prop "$DEVICE1" "$TRANSFORM" 1 0 0 0 1 0 0 0 1
      [ ! -z "$DEVICE2" ] && xinput set-prop "$DEVICE2" "$TRANSFORM" 0 -1 1 1 0 0 0 0 1
      ;;
    inverted)
      [ ! -z "$DEVICE0" ] && xinput set-prop "$DEVICE0" "$TRANSFORM" -1 0 1 0 -1 1 0 0 1
      [ ! -z "$DEVICE1" ] && xinput set-prop "$DEVICE1" "$TRANSFORM" -1 0 1 0 -1 1 0 0 1
      [ ! -z "$DEVICE2" ] && xinput set-prop "$DEVICE2" "$TRANSFORM" 0 1 0 -1 0 1 0 0 1
      ;;
    left)
      [ ! -z "$DEVICE0" ] && xinput set-prop "$DEVICE0" "$TRANSFORM" 0 -1 1 1 0 0 0 0 1
      [ ! -z "$DEVICE1" ] && xinput set-prop "$DEVICE1" "$TRANSFORM" 0 -1 1 1 0 0 0 0 1
      [ ! -z "$DEVICE2" ] && xinput set-prop "$DEVICE2" "$TRANSFORM" -1 0 1 0 -1 1 0 0 1
      ;;
    right)
      [ ! -z "$DEVICE0" ] && xinput set-prop "$DEVICE0" "$TRANSFORM" 0 1 0 -1 0 1 0 0 1
      [ ! -z "$DEVICE1" ] && xinput set-prop "$DEVICE1" "$TRANSFORM" 0 1 0 -1 0 1 0 0 1
      [ ! -z "$DEVICE2" ] && xinput set-prop "$DEVICE2" "$TRANSFORM" 1 0 0 0 1 0 0 0 1
      ;;
  esac

}

#-------------------------------------------------------------------------------

if [ -z "$arg1" ]; then                 # show current
    echo "current rotation:" $CUORI
    exit 0
fi

if [ "$arg1" == "restore" ]; then       # restore
    if [ -f "$file" ]; then             # stored
        ori=`cat $file`
    else                                # current
        ori=$CUORI
    fi
elif [ "$arg1" == "+" ]; then           # +
    for i in ${!ORIA0[*]}; do
        if [ "$CUORI" == ${ORIA0[$i]} ]; then
            ori=${ORIA0[($i+1) % 4]}
            break
        fi
    done
else                                    # new
    ori=$arg1
fi
                                        # check
if [ "$ori" == "normal" ]   || [ "$ori" == "left" ] ||
   [ "$ori" == "inverted" ] || [ "$ori" == "right" ]; then
    :
else                                    # invalid
    echo "invalid argument"
    echo "usage: ./rotate.sh [+|normal|inverted|left|right|restore]"
    exit 1
fi

echo $ori > $file                       # store
do_rotate $CUDIS $ori                   # rotate

if [ $RESTBRIGHT == true ]; then        # restore brightness
    sleep 1                             # delay
    $path/bright.sh restore             # call script
fi
