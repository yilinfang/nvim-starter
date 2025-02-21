#!/bin/bash

# Set up configuration directories
NVIM_CONFIG_DIR="$HOME/.config/nvim"
TMUX_CONFIG_DIR="$HOME/.tmux"
TMUX_CONF="$HOME/.tmux.conf"
TMUX_CONF_LOCAL="$HOME/.tmux.conf.local"

# Configuration repositories
NVIM_CONFIG_REPO="https://github.com/yilinfang/nvim.git"
OHMYTMUX_REPO="https://github.com/yilinfang/.tmux.git"

# Update Neovim configuration
if [ -d "$NVIM_CONFIG_DIR" ]; then
  if [ -d "$NVIM_CONFIG_DIR/.git" ]; then
    echo "Updating existing Neovim configuration..."
    if ! git -C "$NVIM_CONFIG_DIR" pull --ff-only; then
      echo "Failed to update Neovim configuration. Resolve conflicts manually."
    else
      echo "Neovim configuration updated successfully."
    fi
  else
    echo "Directory $NVIM_CONFIG_DIR exists but is not a Git repository. Backing it up..."
    mv "$NVIM_CONFIG_DIR" "$NVIM_CONFIG_DIR.bak.$(date +%s)"
    echo "Cloning Neovim configuration..."
    if ! git clone "$NVIM_CONFIG_REPO" "$NVIM_CONFIG_DIR"; then
      echo "Failed to clone Neovim configuration."
      exit 1
    fi
  fi
else
  echo "Cloning Neovim configuration..."
  if ! git clone "$NVIM_CONFIG_REPO" "$NVIM_CONFIG_DIR"; then
    echo "Failed to clone Neovim configuration."
    exit 1
  fi
fi

# Update Tmux configuration
if [ -d "$TMUX_CONFIG_DIR" ]; then
  if [ -d "$TMUX_CONFIG_DIR/.git" ]; then
    echo "Updating existing Tmux configuration..."
    if ! git -C "$TMUX_CONFIG_DIR" pull --ff-only; then
      echo "Failed to update Tmux configuration. Resolve conflicts manually."
    else
      echo "Tmux configuration updated successfully."
    fi
  else
    echo "Directory $TMUX_CONFIG_DIR exists but is not a Git repository. Backing it up..."
    mv "$TMUX_CONFIG_DIR" "$TMUX_CONFIG_DIR.bak.$(date +%s)"
    echo "Cloning Tmux configuration..."
    if ! git clone "$OHMYTMUX_REPO" "$TMUX_CONFIG_DIR"; then
      echo "Failed to clone Tmux configuration."
      exit 1
    fi
  fi
else
  echo "Cloning Tmux configuration..."
  if ! git clone "$OHMYTMUX_REPO" "$TMUX_CONFIG_DIR"; then
    echo "Failed to clone Tmux configuration."
    exit 1
  fi
fi

# Create symbolic links for Tmux configuration
echo "Creating symbolic links for Tmux configuration..."

# Handle .tmux.conf
if [ -L "$TMUX_CONF" ]; then
  rm "$TMUX_CONF"
elif [ -f "$TMUX_CONF" ]; then
  mv "$TMUX_CONF" "$TMUX_CONF.bak.$(date +%s)"
fi
ln -s "$TMUX_CONFIG_DIR/.tmux.conf" "$TMUX_CONF"

# Handle .tmux.conf.local
if [ -L "$TMUX_CONF_LOCAL" ]; then
  rm "$TMUX_CONF_LOCAL"
elif [ -f "$TMUX_CONF_LOCAL" ]; then
  mv "$TMUX_CONF_LOCAL" "$TMUX_CONF_LOCAL.bak.$(date +%s)"
fi
ln -s "$TMUX_CONFIG_DIR/.tmux.conf.local" "$TMUX_CONF_LOCAL"

echo "Configuration update complete!"
