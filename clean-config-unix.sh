#!/bin/bash

# Cleanup nvim configuration
echo "Cleaning up Neovim configuration..."
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
echo "Cleaning up Neovim configuration...done"

# Cleanup Ohmytmux configuration
echo "Cleaning up Ohmytmux configuration..."
rm ~/.tmux.conf ~/.tmux.conf.local
echo "Cleaning up Ohmytmux configuration...done"
