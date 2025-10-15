# ~/.zprofile — start Hyprland automatically for login sessions

# Only start if we're on the first TTY (prevents loops when using a display manager)
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec Hyprland
fi

export GTK_THEME=oomox-black-space
export GTK_ICON_THEME=oomox-black-space
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"