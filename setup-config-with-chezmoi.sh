#!/usr/bin/env bash

# This script sets up a new machine with a configuration managed by chezmoi.

# Target repository containing the dotfiles
TARGET_REPO="https://github.com/yilinfang/dotfiles.git"

# Ensure chezmoi and age are installed
if ! command -v chezmoi &>/dev/null; then
	echo "chezmoi is not installed. Please install it first."
	exit 1
fi

if ! command -v age &>/dev/null; then
	echo "age is not installed. Please install it first."
	exit 1
fi

# Cleanup any existing chezmoi configuration
if [ -d "$HOME/.config/chezmoi" ]; then
	echo "Removing existing chezmoi config files..."
	rm -rf "$HOME/.config/chezmoi"
fi

if [ -d "$HOME/.local/share/chezmoi" ]; then
	echo "Removing existing chezmoi configuration..."
	rm -rf "$HOME/.local/share/chezmoi"
fi

# Initialize chezmoi with the target repository
echo "Initializing chezmoi with the repository: $TARGET_REPO"
chezmoi init "$TARGET_REPO"

# Apply selected dotfiles

# age keys
echo "Applying age keys..."
chezmoi apply ~/.age

# neovim
echo "Applying neovim configuration..."
chezmoi apply ~/.config/nvim

# tmux
echo "Applying tmux configuration..."
chezmoi apply ~/.tmux.conf

# LazyGit
echo "Applying LazyGit configuration..."
chezmoi apply ~/.config/lazygit

# Yazi
echo "Applying Yazi configuration..."
chezmoi apply ~/.config/yazi

# github-copilot
echo "Applying GitHub Copilot configuration..."
chezmoi apply ~/.config/github-copilot

# Finish setup
echo "Setup complete!"
