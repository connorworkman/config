#!/bin/bash

# Use a different browser depending on url

imgurredirect(){
    url="$(curl "$1" 2>/dev/null|grep '<meta property="og:image"')"
    url="${url/*content=\"/}"
    url="${url/*\" \/>$/}"
    feh "$url"
    #/usr/bin/chromium "$url"
    #~/bin/pyb "$url"
    #/usr/bin/google-chrome-stable "$url"
}

mpvcmd(){
    notify-send "mpv: loading..." "$1"
    mpv --loop=inf "$@"
}

case $1 in
  *.webm|*.gif|*.gifv|*.mp4|*.avi|*.mkv|*.mov|*.swf|*.flv) mpvcmd "$1" ;;
  #*://ptpb.pw/*) ~/bin/pyb "$1" ;;
  #*://i.imgur.com/*) ~/bin/pyb "$1" ;;
  #*://i.imgur.com/*) /usr/bin/chromium "$1" ;;
  *://i.imgur.com/*) feh "$1" ;;
  *://imgur.com/*) imgurredirect "$1" ;;
  *.jpg|*.jpeg|*.png) feh "$1" ;;
  #*.pdf) /usr/bin/foxitreader "$1" ;;
  #*://dpaste.de/*) ~/bin/pyb "$1" ;;
  *://*youtube.com/*) mpvcmd "$1" ;;
  *://*youtu.be/*) mpvcmd "$1" ;;
  *) /usr/bin/chromium "$1" ;;
  #*) /usr/bin/firefox -new-tab "$1" ;;
esac
