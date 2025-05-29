#!/usr/bin/env bash

# This script sets up a new machine with a configuration managed by chezmoi.

# Ensure chezmoi and age are installed
if ! command -v chezmoi &>/dev/null; then
	echo "chezmoi is not installed. Please install it first."
	exit 1
fi

if ! command -v age &>/dev/null; then
	echo "age is not installed. Please install it first."
	exit 1
fi

# Target repository containing the dotfiles
TARGET_REPO="https://github.com/yilinfang/dotfiles.git"
SOURCE_DIR="$HOME/.chezmoi/dotfiles"

# Get current script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Configuration file containing paths to apply
CONFIG_FILE="$SCRIPT_DIR/config.txt"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
	echo "Configuration file not found: $CONFIG_FILE"
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
chezmoi init "$TARGET_REPO" -S "$SOURCE_DIR"

# Apply selected dotfiles from configuration file
while IFS= read -r path || [ -n "$path" ]; do
	# Skip empty lines
	if [[ -z "$path" ]]; then
		continue
	fi

	# Trim whitespace
	path=$(echo "$path" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

	echo "Applying $path..."
	chezmoi apply -v -r "$path"
done <"$CONFIG_FILE"

# Finish setup
echo "Setup complete!"
