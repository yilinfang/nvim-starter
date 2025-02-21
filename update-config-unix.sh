#!/bin/bash

# Set up configuration directories
NVIM_CONFIG_DIR="$HOME/.config/nvim"
ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"

# Configuration repositories
NVIM_CONFIG_REPO="https://github.com/yilinfang/nvim.git"
ZELLIJ_CONFIG_REPO="https://github.com/yilinfang/zellij.git"

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

# Update Zellij configuration
if [ -d "$ZELLIJ_CONFIG_DIR" ]; then
  if [ -d "$ZELLIJ_CONFIG_DIR/.git" ]; then
    echo "Updating existing Zellij configuration..."
    if ! git -C "$ZELLIJ_CONFIG_DIR" pull --ff-only; then
      echo "Failed to update Zellij configuration. Resolve conflicts manually."
    else
      echo "Zellij configuration updated successfully."
    fi
  else
    echo "Directory $ZELLIJ_CONFIG_DIR exists but is not a Git repository. Backing it up..."
    mv "$ZELLIJ_CONFIG_DIR" "$ZELLIJ_CONFIG_DIR.bak.$(date +%s)"
    echo "Cloning Zellij configuration..."
    if ! git clone "$ZELLIJ_CONFIG_REPO" "$ZELLIJ_CONFIG_DIR"; then
      echo "Failed to clone Zellij configuration."
      exit 1
    fi
  fi
else
  echo "Cloning Zellij configuration..."
  if ! git clone "$ZELLIJ_CONFIG_REPO" "$ZELLIJ_CONFIG_DIR"; then
    echo "Failed to clone Zellij configuration."
    exit 1
  fi
fi

echo "Configuration update complete!"
