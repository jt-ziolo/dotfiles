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
