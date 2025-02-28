#!/bin/bash

# Function to remove installed tools
remove_tools() {
  echo "Removing installed tools..."
  rm -rf "$HOME/.nvim-starter"
  echo "Removing installed tools...done"
}

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
  echo "Cleaning up tmux configuration...done"
}

# Function to clean Zellij configuration
clean_zellij() {
  echo "Cleaning up Zellij configuration..."
  rm -rf ~/.config/zellij
  echo "Cleaning up Zellij configuration...done"
}

# Menu to select which tools to uninstall
while true; do
  echo "Select the tools to uninstall (you can select multiple, e.g., '1 2'):"
  echo "1. Neovim"
  echo "2. tmux"
  echo "3. Zellij"
  echo "4. All"
  read -p "Enter your choice(s) [1-4]: " choices

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
      clean_nvim
      clean_tmux
      clean_zellij
      remove_tools
      break 2
      ;;
    *)
      echo "Invalid choice: $choice. Please enter a number between 1 and 4."
      ;;
    esac
  done
done

echo "Uninstallation process completed!"

# Remind user to manually edit the shell configuration file
echo "Please remember to manually edit your shell configuration file to remove any references to the tools you have uninstalled."