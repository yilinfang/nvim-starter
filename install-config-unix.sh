#!/usr/bin/env bash

# Function to install a git repository
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

# Configuration directories and repositories
NVIM_CONFIG_DIR="$HOME/.config/nvim"
TMUX_CONFIG_DIR="$HOME/.config/tmux"
ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"
YAZI_CONFIG_DIR="$HOME/.config/yazi"

NVIM_CONFIG_REPO="https://github.com/yilinfang/nvim.git"
TMUX_CONFIG_REPO="https://github.com/yilinfang/tmux.git"
ZELLIJ_CONFIG_REPO="https://github.com/yilinfang/zellij.git"
YAZI_CONFIG_REPO="https://github.com/yilinfang/yazi.git"

# Menu to select which configurations to install
echo "Select the configurations to install (you can select multiple, e.g., '1 2'):"
echo "1. Neovim"
echo "2. Tmux"
echo "3. Zellij"
echo "4. Yazi"
echo "5. All"
read -p "Enter your choice(s) [1-5]: " choices

for choice in $choices; do
  case $choice in
  1)
    install_config "Neovim" "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_REPO"
    ;;
  2)
    install_config "tmux" "$TMUX_CONFIG_DIR" "$TMUX_CONFIG_REPO"
    /usr/bin/env bash "$TMUX_CONFIG_DIR/install.sh"
    ;;
  3)
    install_config "Zellij" "$ZELLIJ_CONFIG_DIR" "$ZELLIJ_CONFIG_REPO"
    ;;
  4)
    install_config "Yazi" "$YAZI_CONFIG_DIR" "$YAZI_CONFIG_REPO"
    ;;
  5)
    install_config "Neovim" "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_REPO"
    install_config "tmux" "$TMUX_CONFIG_DIR" "$TMUX_CONFIG_REPO"
    install_config "Zellij" "$ZELLIJ_CONFIG_DIR" "$ZELLIJ_CONFIG_REPO"
    install_config "Yazi" "$YAZI_CONFIG_DIR" "$YAZI_CONFIG_REPO"
    break
    ;;
  *)
    echo "Invalid choice: $choice. Please enter a number between 1 and 5."
    ;;
  esac
done

echo "Installation process completed!"
