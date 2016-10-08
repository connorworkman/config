#!/bin/sh

DISPLAY=:0.0 /usr/bin/xmodmap "/home/alyptik/.Xmodmap"
DISPLAY=:0.0 /usr/bin/setxkbmap -option terminate:ctrl_alt_bksp
DISPLAY=:0.0 /usr/bin/setxkbmap -option compose:caps

