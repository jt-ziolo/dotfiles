#!/bin/sh

run() {
  if ! pgrep -f "$1" ;
  then
    "$@"&
  fi
}

echo "Setting up modifier 3 key"
run xmodmap ~/.config/.Xmodmap

echo "Starting picom compositor in background (window effects)"
run picom -b

echo "Starting v4l2loopback"
run modprobe v4l2loopback-ctl

echo "Starting nm-applet for ProtonVPN"
run nm-applet

echo "Starting common desktop apps"
run cryptomator
run protonvpn
run keepassxc

