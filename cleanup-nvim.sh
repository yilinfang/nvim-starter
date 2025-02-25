#!/bin/bash

# Check for the -a argument
if [[ "$1" == "-a" ]]; then
  echo "Removing ~/.config/nvim"
  rm -rf ~/.config/nvim
fi

# Remove other Neovim-related directories
echo "Removing ~/.local/state/nvim"
rm -rf ~/.local/state/nvim

echo "Removing ~/.local/share/nvim"
rm -rf ~/.local/share/nvim

echo "Removing ~/.cache/nvim"
rm -rf ~/.cache/nvim

echo "Cleanup complete."
