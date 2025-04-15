#!/usr/bin/env bash

# Function to clean Neovim configuration
clean_nvim() {
  echo "Cleaning up Neovim configuration..."
  rm -rf ~/.config/nvim
  rm -rf ~/.local/state/nvim
  rm -rf ~/.local/share/nvim
  rm -rf ~/.cache/nvim
  echo "Cleaning up Neovim configuration...done"
}

# Function to clean tmux configuration
clean_tmux() {
  echo "Cleaning up tmux configuration..."
  rm -rf ~/.config/tmux
  rm -rf ~/.tmux.conf
  rm -rf ~/.tmux.conf.local
  echo "Cleaning up tmux configuration...done"
}

# Menu to select which tools to clean
echo "Select the tools to clean (you can select multiple, e.g., '1 2'):"
echo "1. Neovim"
echo "2. Tmux"
echo "a. All"
read -p "Enter your choice(s): " choices

for choice in $choices; do
  case $choice in
  1)
    clean_nvim
    ;;
  2)
    clean_tmux
    ;;
  a)
    clean_nvim
    clean_tmux
    ;;
  *)
    echo "Invalid choice: $choice."
    ;;
  esac
done
