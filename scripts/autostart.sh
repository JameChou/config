#!/bin/bash


/bin/bash ~/Software/bin/dwm.script/dwm-status.sh &
# set the screen
xrandr --output Virtual-1 --mod 1920x1080 --rate 60.00

# set wallpapers
feh --bg-fill --no-fehbg -z ~/Pictures/wallpapers/* &

# set the fcitx
fcitx5 -d &
#


# set the keyboard layouts
/bin/bash ~/Scripts/setxmodmap.sh
