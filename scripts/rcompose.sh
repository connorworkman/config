#!/bin/sh

(sleep 1 && setxkbmap -option terminate:ctrl_alt_bksp)
(sleep 1 && setxkbmap -option compose:caps)
(sleep 1 && xmodmap "/home/alyptik/.Xmodmap")

