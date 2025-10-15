#!/usr/bin/env bash
set -euo pipefail

# --- WiFi setup (if needed) ---
echo "Checking for NetworkManager / nmcli..."
if ! command -v nmcli &>/dev/null; then
  echo "nmcli not found — installing NetworkManager..."
  sudo pacman -S --needed networkmanager --noconfirm
  sudo systemctl enable --now NetworkManager
fi

# Poll for interface
echo "Listing wireless devices:"
nmcli device status

# Prompt for SSID / password
read -rp "WiFi SSID: " WIFI_SSID
read -rsp "WiFi Password: " WIFI_PASS
echo

echo "Connecting to WiFi..."
nmcli device wifi connect "$WIFI_SSID" password "$WIFI_PASS"

echo "Waiting for network..."
for i in {1..10}; do
  if ping -c 1 google.com &>/dev/null; then
    echo "Network OK!"
    break
  else
    echo "Waiting... ($i/10)"
    sleep 2
  fi
done

# (Optional) If not connected by now, exit
if ! ping -c 1 google.com &>/dev/null; then
  echo "ERROR: Could not connect to network. Aborting installation."
  exit 1
fi

echo "WiFi connected, proceeding with installation..."

# --- rest of your script continues here ---
if [[ $EUID -ne 0 ]]; then
  echo "Please run this script as root: "
  echo " sudo bash $0"
  exit 1
fi

echo "Setting up system from dotfiles..."

# --- Update and install base tools ---
pacman -Syu --noconfirm
pacman -S --needed git stow base-devel --noconfirm

# --- Install yay if missing ---
if ! command -v yay &>/dev/null; then
  echo "Installing yay..."
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  cd /tmp/yay && makepkg -si --noconfirm
  cd -
fi

# --- Install all packages ---
if [[ -f pkglist.txt ]]; then
  echo "Installing pacman packages..."
  pacman -S --needed - < pkglist.txt --noconfirm
fi

if [[ -f aurlist.txt ]]; then
  echo "Installing AUR packages..."
  yay -S --needed - < aurlist.txt --noconfirm
fi

# --- Stow all configs ---
echo "Linking dotfiles..."
cd ~/dotfiles
stow -t ~/.config --adopt .config
stow -t ~/.local  --adopt .local
stow -t ~         --adopt zsh

echo "Setup complete!"
echo "Detected host: $(hostname)"
