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

# Function to clean Zellij configuration
clean_zellij() {
  echo "Cleaning up Zellij configuration..."
  rm -rf ~/.config/zellij
  echo "Cleaning up Zellij configuration...done"
}

# Function to clean Yazi configuration
clean_yazi() {
  echo "Cleaning up Yazi configuration..."
  rm -rf ~/.config/yazi
  echo "Cleaning up Yazi configuration...done"
}

# Menu to select which tools to clean
echo "Select the tools to clean (you can select multiple, e.g., '1 2'):"
echo "1. Neovim"
echo "2. tmux"
echo "3. Zellij"
echo "4. Yazi"
echo "5. All"
read -p "Enter your choice(s) [1-5]: " choices

for choice in $choices; do
  case $choice in
  1)
    clean_nvim
    ;;
  2)
    clean_tmux
    ;;
  3)
    clean_zellij
    ;;
  4)
    clean_yazi
    ;;
  5)
    clean_nvim
    clean_tmux
    clean_zellij
    clean_yazi
    ;;
  *)
    echo "Invalid choice: $choice. Please enter a number between 1 and 5."
    ;;
  esac
done
