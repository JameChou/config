#!/bin/sh

xrdb=xrdb
xinitdir=/etc/X11/xinit
xclock=xclock
xterm=xterm
twm=twm
xmodmap=xmodmap

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=$xinitdir/.Xresources
sysmodmap=$xinitdir/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    if [ -x /usr/bin/cpp ] ; then
        $xrdb -merge $sysresources
    else
        $xrdb -nocpp -merge $sysresources
    fi
fi

if [ -f $sysmodmap ]; then
    $xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        $xrdb -merge "$userresources"
    else
        $xrdb -nocpp -merge "$userresources"
    fi
fi

if [ -f "$usermodmap" ]; then
    $xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d $xinitdir/xinitrc.d ] ; then
 for f in "$xinitdir/xinitrc.d"/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# xrdb scaling resoluation
# xrdb -merge ~/.Xresources

# keyboard layout
xmodmap ~/.xmodmap &

# fcitx5 input method
fcitx5 -d

# monitor configuration
xrandr --output eDP-1 --auto --scale 1.1x1.1 

# startup the dwm window manager
exec dwm
