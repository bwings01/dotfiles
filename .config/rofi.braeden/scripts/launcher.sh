#!/usr/bin/env bash
# Rofi launcher with Favorites and Apps tabs
# Works with modi: "drun,drun" in config

rofi \
  -show favorites \
  -modi "favorites:drun -drun-match-fields Categories -drun-categories Favorites,apps:drun" \
  -theme ~/.config/rofi.braeden/style.rasi \
  -show-icons true \
  -display-favorites "FAVORITES" \
  -display-apps "APPS"
