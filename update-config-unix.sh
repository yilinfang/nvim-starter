#!/bin/bash

# Script to update zellij, tmux, and neovim configurations via git
# Created: February 27, 2025

# Repository URLs
NVIM_CONFIG_REPO="https://github.com/yilinfang/nvim.git"
TMUX_CONFIG_REPO="https://github.com/yilinfang/tmux.git"
ZELLIJ_CONFIG_REPO="https://github.com/yilinfang/zellij.git"

# Configuration paths
NVIM_CONFIG_PATH="$HOME/.config/nvim"
TMUX_CONFIG_PATH="$HOME/.config/tmux"
ZELLIJ_CONFIG_PATH="$HOME/.config/zellij"

# Set colors for better output readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to create backup of existing configuration
backup_config() {
  local config_name=$1
  local config_path=$2
  local backup_path="${config_path}_backup_$(date +%Y%m%d_%H%M%S)"

  echo -e "${BLUE}Creating backup of existing ${config_name} configuration...${NC}"
  if cp -r "$config_path" "$backup_path"; then
    echo -e "${GREEN}Backup created at: ${backup_path}${NC}"
    return 0
  else
    echo -e "${RED}Failed to create backup of ${config_name} configuration.${NC}"
    return 1
  fi
}

# Function to update a configuration repository
update_config() {
  local config_name=$1
  local config_path=$2
  local repo_url=$3

  echo -e "\n${YELLOW}=== Processing ${config_name} configuration ===${NC}"

  # Check if directory exists
  if [ ! -d "$config_path" ]; then
    echo -e "${BLUE}${config_path} directory not found. Cloning from repository...${NC}"
    mkdir -p "$(dirname "$config_path")"
    if git clone "$repo_url" "$config_path"; then
      echo -e "${GREEN}${config_name} configuration cloned successfully.${NC}"
      return 0
    else
      echo -e "${RED}Failed to clone ${config_name} configuration.${NC}"
      return 1
    fi
  fi

  # Navigate to the configuration directory
  cd "$config_path" || return 1

  # Check if it's a git repository
  if [ ! -d ".git" ]; then
    echo -e "${YELLOW}${config_path} is not a git repository.${NC}"
    echo -e "${BLUE}Would you like to back up the existing configuration and clone the repository? (y/n)${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
      backup_config "$config_name" "$config_path"
      cd ..
      rm -rf "$config_path"
      if git clone "$repo_url" "$config_path"; then
        echo -e "${GREEN}${config_name} configuration cloned successfully.${NC}"
        return 0
      else
        echo -e "${RED}Failed to clone ${config_name} configuration.${NC}"
        return 1
      fi
    else
      echo -e "${YELLOW}Skipping ${config_name} configuration update.${NC}"
      return 0
    fi
  fi

  # Check if there are uncommitted changes
  if ! git diff-index --quiet HEAD --; then
    echo -e "${YELLOW}There are uncommitted changes in your ${config_name} configuration.${NC}"
    echo -e "${BLUE}Would you like to stash these changes before updating? (y/n)${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
      git stash
      echo -e "${GREEN}Local changes stashed.${NC}"
    else
      echo -e "${YELLOW}Proceeding with local changes. This might cause conflicts.${NC}"
    fi
  fi

  # Pull the latest changes
  echo -e "${BLUE}Pulling latest changes from repository...${NC}"
  if git pull; then
    echo -e "${GREEN}${config_name} configuration updated successfully.${NC}"
  else
    echo -e "${RED}There were conflicts updating ${config_name} configuration.${NC}"
    echo -e "${YELLOW}Please resolve conflicts manually and commit your changes.${NC}"
    echo -e "${BLUE}Would you like to open this directory to resolve conflicts now? (y/n)${NC}"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
      # Open directory with default file manager or editor
      if command -v xdg-open &>/dev/null; then
        xdg-open .
      elif command -v open &>/dev/null; then
        open .
      else
        echo -e "${YELLOW}Could not open directory automatically. Please navigate to: ${config_path}${NC}"
      fi
    fi
    return 1
  fi

  # Check if there are stashed changes to apply
  if git stash list | grep -q "stash@{0}"; then
    echo -e "${BLUE}Attempting to apply stashed changes...${NC}"
    if git stash apply; then
      echo -e "${GREEN}Stashed changes applied successfully.${NC}"
      echo -e "${YELLOW}Please check for any conflicts and resolve them manually.${NC}"
    else
      echo -e "${RED}Failed to apply stashed changes due to conflicts.${NC}"
      echo -e "${YELLOW}Please resolve conflicts manually using: git stash pop${NC}"
    fi
  fi

  return 0
}

# Main script

# Welcome message
echo -e "${GREEN}=== Configuration Update Script ===${NC}"
echo "This script will update your zellij, tmux, and neovim configurations."
echo "If configurations don't exist, they will be cloned from the repositories."
echo "If configurations exist but aren't git repositories, they will be backed up first."
echo

# Update each configuration
update_config "Neovim" "$NVIM_CONFIG_PATH" "$NVIM_CONFIG_REPO"
update_config "Tmux" "$TMUX_CONFIG_PATH" "$TMUX_CONFIG_REPO"
update_config "Zellij" "$ZELLIJ_CONFIG_PATH" "$ZELLIJ_CONFIG_REPO"

echo
echo -e "${GREEN}All configurations have been processed.${NC}"
echo "Please check for any error messages above."
