#!/bin/sh &

xbindkeys &
xset s noblank &
xset s off -b -dpms &
setterm -blank 0 -powerdown 0 &
xsetroot -cursor_name left_ptr &

xrdb "/home/alyptik/.Xresources" &

#yeahconsole -rv &
#yeahconsole &
#urxvtc -kuake-hotkey F12 &
compton -cCGfF -b -i 0.90 &
#feh --bg-scale /home/alyptik/Wallpapers/fifths.png &
feh --bg-scale "/home/alyptik/Wallpapers/modes.png" &

setxkbmap -option "terminate:ctrl_alt_bksp" &
setxkbmap -option "compose:caps" &
xmodmap "/home/alyptik/.Xmodmap" &

#xrandr --output eDP1 --auto --mode 2160x1440 &
#xrandr --output eDP1 --scale .85x.85 &
#xrandr --output eDP1 --scale 1x1 &

#urxvtcd &
#urxvtcd -kuake-hotkey "F12" &
#urxvtc -kuake-hotkey "F12" &
#stjerm -k F12 -ah false -o 90 -b thin -w 90% -h 80% -ar -tf true -fn "Inconsolata Thin 20" &
stjerm -k F12 -ah false -o 85 -b none -w 95% -h 85% -ar -tf true -tp bottom -fn "Inconsolata Thin 22" &
urxvt -kuake-hotkey F10 &

