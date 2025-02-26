#!/bin/bash

# Cleanup nvim configuration
echo "Cleaning up Neovim configuration..."
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
echo "Cleaning up Neovim configuration...done"

# CLeanup tmux configuration

echo "Cleaning up tmux configuration..."
rm -rf ~/.config/tmux
echo "Cleaning up tmux configuration...done"

# Cleanup zellij configuration
echo "Cleaning up Zellij configuration..."
rm -rf ~/.config/zellij
echo "Cleaning up Zellij configuration...done"
