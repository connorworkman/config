#!/bin/sh

# Here i4 is kept as default

#yeahconsole -rv &
#yeahconsole &
#urxvtc -kuake-hotkey F13 &
#urxvt -kuake-hotkey "F13" &
#stjerm -k f11 -ah true -o 90 -b thin -w 90% -h 80% -ar -tf true -fn "Inconsolata Thin 20" &
#compton -cCGfF -b -i 1.90 &
#feh --bg-scale /home/alyptik/Wallpapers/fifths.png &
#feh --bg-scale /home/alyptik/Wallpapers/modes.png &
xbindkeys &
xset s noblank &
xset s off -b -dpms &
setterm -blank 1 -powerdown 0 &
xsetroot -cursor_name left_ptr &

xrdb "/home/alyptik/.Xresources"

#yeahconsole -rv &
#yeahconsole
#urxvtc -kuake-hotkey F12
#compton -cCGfF -b -i .90 &
#feh --bg-scale /home/alyptik/Wallpapers/fifths.png
#feh --bg-scale "/home/alyptik/Wallpapers/modes.png"

setxkbmap -option "terminate:ctrl_alt_bksp" &
setxkbmap -option "compose:caps" &
xmodmap "/home/alyptik/.Xmodmap" &

#urxvtcd
#urxvtcd -kuake-hotkey "F13"
#urxvtc -kuake-hotkey "F13"
#stjerm -k F13 -ah false -o 90 -b thin -w 90% -h 80% -ar -tf true -fn "Inconsolata Thin 20"
stjerm -k F13 -ah false -o 85 -b none -w 95% -h 85% -ar -tf true -tp bottom -fn "Inconsolata Thin 22" &
urxvt -kuake-hotkey F11 &

default_session="i3";

if [[ $1 == xterm ]] && [[ -n $2 ]]; then
    session="$2";
elif [[ "$1"x == x ]]; then
    if [[ -e ~/.WM.default ]]; then
        session="$(cat ~/.WM.default)";
    else
        session="$default_session";
    fi;
else
    session="$1";
fi;

printf "$session\n" > ~/.WM.last;

case $session in
    awesome )
        xscreensaver &
        exec awesome;;

    bspwm )
        xscreensaver &
        exec bspwm;;

    budgie-desktop )
        gnome-screensaver &
        exec budgie-desktop;;

    catwm )
        xscreensaver &
        exec catwm;;

    cinnamon )
        xscreensaver &
        exec cinnamon-session;;

    dwm )
        xscreensaver &
        exec dwm;;

    ede )
        xscreensaver &
        exec startede;;

    enlightenment )
        xscreensaver &
        exec enlightenment_start;;

    fluxbox )
        xscreensaver &
        exec startfluxbox;;

    gnome )
        gnome-screensaver &
        exec gnome-session;;

    gnome-classic )
        gnome-screensaver &
        exec gnome-session --session=gnome-classic;;

    i3|i3wm )
        xscreensaver &
        exec i3;;

    icewm )
        xscreensaver &
        exec icewm-session;;

    jwm )
        xscreensaver &
        exec jwm;;

    kde )
        xscreensaver &
        exec startkde;;

    mate )
        xscreensaver &
        exec mate-session;;

    monster|monsterwm )
        xscreensaver &
        exec monsterwm;;

    notion )
        xscreensaver &
        exec notion;;

    openbox )
        xscreensaver &
        exec openbox-session;;

    unity )
        xscreensaver &
        exec unity;;

    xfce|xfce4 )
        xscreensaver &
        exec startxfce4;;

    xmonad )
        xscreensaver &
        exec xmonad;;

    # No known session, try to run it as command
    * )
        xscreensaver &
        exec $session;;
esac;
