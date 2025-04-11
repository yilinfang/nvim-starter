#!/usr/bin/env bash

# Function to update a git repository with conflict handling
update_config() {
  local config_name="$1"
  local config_dir="$2"

  echo "Checking $config_name configuration..."

  # Check if directory exists and is a git repository
  if [ -d "$config_dir/.git" ]; then
    echo "Updating $config_name configuration..."

    # Try to pull, capturing output and exit status
    cd "$config_dir"
    output=$(git pull 2>&1)
    status=$?

    if [ $status -eq 0 ]; then
      if echo "$output" | grep -q "Already up to date"; then
        echo "$config_name is already up to date"
      else
        echo "$config_name updated successfully"
      fi
    else
      if echo "$output" | grep -q "conflict"; then
        echo "⚠️  Warning: Conflicts detected in $config_name configuration"
        echo "Please resolve conflicts manually in $config_dir"
        # Reset to original state to prevent partial merges
        git reset --hard HEAD
        git clean -fd
      else
        echo "❌ Error updating $config_name configuration: $output"
      fi
    fi
  else
    echo "❌ $config_name configuration directory not found or not a git repository"
    echo "You may need to run the installation script first"
  fi
}

# Configuration directories (matching the ones used in starter scripts)
NVIM_CONFIG_DIR="$HOME/.config/nvim"
TMUX_CONFIG_DIR="$HOME/.config/tmux"
ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"
YAZI_CONFIG_DIR="$HOME/.config/yazi"

# Menu to select which configs to update
echo "Select the configurations to update (you can select multiple, e.g., '1 2'):"
echo "1. Neovim"
echo "2. Tmux"
echo "3. Zellij"
echo "4. Yazi"
echo "5. All"
read -p "Enter your choice(s) [1-5]: " choices

for choice in $choices; do
  case $choice in
  1)
    update_config "Neovim" "$NVIM_CONFIG_DIR"
    ;;
  2)
    update_config "tmux" "$TMUX_CONFIG_DIR"
    ;;
  3)
    update_config "Zellij" "$ZELLIJ_CONFIG_DIR"
    ;;
  4)
    update_config "Yazi" "$YAZI_CONFIG_DIR"
    ;;
  5)
    update_config "Neovim" "$NVIM_CONFIG_DIR"
    update_config "tmux" "$TMUX_CONFIG_DIR"
    update_config "Zellij" "$ZELLIJ_CONFIG_DIR"
    update_config "Yazi" "$YAZI_CONFIG_DIR"
    break
    ;;
  *)
    echo "Invalid choice: $choice. Please enter a number between 1 and 4."
    ;;
  esac
done

echo "Update process completed!"
