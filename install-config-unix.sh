#!/usr/bin/env bash

# Configuration registry: name|install_function
CONFIGS=(
  "Lazygit|install_lazygit"
  "Neovim|install_nvim"
  "Tmux|install_tmux"
  "Yazi|install_yazi"
)

# Configuration directories and repositories
NVIM_CONFIG_DIR="$HOME/.config/nvim"
TMUX_CONFIG_DIR="$HOME/.config/tmux"
LAZYGIT_CONFIG_DIR="$HOME/.config/lazygit"
YAZI_CONFIG_DIR="$HOME/.config/yazi"

NVIM_CONFIG_REPO="https://github.com/yilinfang/nvim.git"
TMUX_CONFIG_REPO="https://github.com/yilinfang/tmux.git"
LAZYGIT_CONFIG_REPO="https://github.com/yilinfang/lazygit.git"
YAZI_CONFIG_REPO="https://github.com/yilinfang/yazi.git"

# Helper function to install a git repository
install_config() {
  local config_name="$1"
  local config_dir="$2"
  local config_repo="$3"

  echo "Installing $config_name configuration..."

  # Check if the directory already exists
  if [ -d "$config_dir" ]; then
    echo "⚠️  $config_name configuration directory already exists at $config_dir"
    read -p "Do you want to overwrite it? (y/n): " overwrite_choice
    if [[ "$overwrite_choice" =~ ^[Yy]$ ]]; then
      rm -rf "$config_dir"
    else
      echo "Skipping installation for $config_name."
      return
    fi
  fi

  # Clone the repository
  git clone "$config_repo" "$config_dir"
  if [ $? -eq 0 ]; then
    echo "$config_name configuration installed successfully at $config_dir."
  else
    echo "❌ Failed to install $config_name configuration. Please check the repository URL or your network connection."
  fi
}

install_lazygit() {
  install_config "Lazygit" "$LAZYGIT_CONFIG_DIR" "$LAZYGIT_CONFIG_REPO"
}

install_nvim() {
  install_config "Neovim" "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_REPO"
}

install_yazi() {
  install_config "Yazi" "$YAZI_CONFIG_DIR" "$YAZI_CONFIG_REPO"
}

install_tmux() {
  install_config "Tmux" "$TMUX_CONFIG_DIR" "$TMUX_CONFIG_REPO"
}

# Show menu for config selection
show_menu() {
  echo "Select configurations to install:"
  local idx=1
  for entry in "${CONFIGS[@]}"; do
    IFS='|' read -r name _ <<<"$entry"
    printf "%2d. %s\n" "$idx" "$name"
    ((idx++))
  done
  echo " a. Install all configurations"
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

  echo "Installation process completed!"
}

main "$@"
