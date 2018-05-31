#!/bin/bash

# bright.sh V0.5 180531 qrt@qland.de
# linux bash script for brighness control

# make script executable
# chmod a+x bright.sh

MIN=10                                  # constants                                  
MAX=100
STEP=5

file="`dirname \"$0\"`/bright.dat"      # arguments
action="$1"                             

CUDIS=`xrandr --current | grep primary | sed -e 's/ .*//g'` # current display

if [ -f "$file" ]; then                
    value=`cat $file`                   # get
else    
    value=50                            # default
fi

if [ "$action" == "restore" ]; then     # restore 
    :
elif [ "$action" == "-" ]; then         # decrement
    value=$(($value-$STEP))
elif [ "$action" == "+" ]; then         # increment
    value=$(($value+$STEP))
elif [[ "$action" =~ ^[0-9]+$ ]]; then  # set
    value=$action
elif [ -z "$action" ]; then             # show
    echo "current brightness" $value
    exit 0
else                                    # invalid
    echo "invalid argument"
    echo "usage: ./bright.sh [-|+|[10-100]|restore]"     
    exit 1
fi

if [ $value -gt $MAX ]; then            # range
    value=100
elif [ $value -lt $MIN ]; then
    value=10     
fi

echo $value > $file                     # store

xrandr --output $CUDIS --brightness $(awk "BEGIN {print $value/$MAX; exit}")
