#!/usr/bin/env bash

# Configuration registry: name|clean_function
CONFIGS=(
  "Lazygit|clean_lazygit"
  "Neovim|clean_nvim"
  "Tmux|clean_tmux"
  "Yazi|clean_yazi"
)

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
  rm -rf ~/.tmux
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

# Show menu for config selection
show_menu() {
  echo "Select configurations to cleanup:"
  local idx=1
  for entry in "${CONFIGS[@]}"; do
    IFS='|' read -r name _ <<<"$entry"
    printf "%2d. %s\n" "$idx" "$name"
    ((idx++))
  done
  echo " a. Cleanup all configurations"
}

main() {
  # Show menu
  show_menu

  # Read user choice
  read -p "Your choice: " CHOICE

  # Process user choice
  if [[ "$CHOICE" == "a" ]]; then
    for entry in "${CONFIGS[@]}"; do
      IFS='|' read -r name func <<<"$entry"
      "$func"
    done
  else
    for num in $CHOICE; do
      if [[ "$num" =~ ^[0-9]+$ ]] && ((num >= 1 && num <= ${#CONFIGS[@]})); then
        IFS='|' read -r name func <<<"${CONFIGS[$((num - 1))]}"
        "$func"
      else
        echo "Invalid option: $num"
      fi
    done
  fi

  echo "Cleanup process completed!"
}

main "$@"
