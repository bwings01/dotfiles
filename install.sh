#!/usr/bin/env bash
set -euo pipefail

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
