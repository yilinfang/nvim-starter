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

# Function to clean lazygit configuration
clean_lazygit() {
  echo "Cleaning up lazygit configuration..."
  rm -rf ~/.config/lazygit
  echo "Cleaning up lazygit configuration...done"
}

# Function to clean yazi configuration
clean_yazi() {
  echo "Cleaning up yazi configuration..."
  rm -rf ~/.config/yazi
  echo "Cleaning up yazi configuration...done"
}

# Menu to select which tools to clean
echo "Select the tools to clean (you can select multiple, e.g., '1 2'):"
echo "1. Neovim"
echo "2. Tmux"
echo "3. Lazygit"
echo "4. Yazi"
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
  3)
    clean_lazygit
    ;;
  4)
    clean_yazi
    ;;
  a)
    clean_nvim
    clean_tmux
    clean_lazygit
    clean_yazi
    ;;
  *)
    echo "Invalid choice: $choice."
    ;;
  esac
done
