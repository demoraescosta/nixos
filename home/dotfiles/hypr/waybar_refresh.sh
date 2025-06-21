#!/usr/bin/env bash
# Kill and restart waybar whenever its config files change
CONFIG_FILE="$HOME/.config/waybar/config.jsonc"

cleanup() {
  pkill waybar
}

trap cleanup EXIT

while true; do
  inotifywait -e create,modify ~/.config/waybar/*
  pkill waybar
  waybar &
done

