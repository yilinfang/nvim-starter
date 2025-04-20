#!/usr/bin/env bash

# Set up directories
PREFIX="$HOME/.pde"

# Create the prefix directory if it doesn't exist
mkdir -p "$PREFIX"

INSTALL_DIR="$PREFIX/bin"
TEMP_DIR="$PREFIX/tmp"
NEOVIM_DIR="$PREFIX/neovim"
NODEJS_DIR="$PREFIX/nodejs"
ZELLIJ_DIR="$PREFIX/zellij"
FD_DIR="$PREFIX/fd"
RG_DIR="$PREFIX/rg"
BAT_DIR="$PREFIX/bat"
FZF_DIR="$PREFIX/fzf"
LAZYGIT_DIR="$PREFIX/lazygit"
YAZI_DIR="$PREFIX/yazi"
SAD_DIR="$PREFIX/sad"
DIFFTASTIC_DIR="$PREFIX/difftastic"
DELTA_DIR="$PREFIX/delta"
TMUX_DIR="$PREFIX/tmux"
LSD_DIR="$PREFIX/lsd"
ZOXIDE_DIR="$PREFIX/zoxide"
FW_DIR="$PREFIX/fw"

# URLs for tools
NEOVIM_URL="https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-macos-arm64.tar.gz"
NODEJS_URL="https://nodejs.org/dist/v22.14.0/node-v22.14.0-darwin-arm64.tar.gz"
ZELLIJ_URL="https://github.com/zellij-org/zellij/releases/download/v0.42.1/zellij-aarch64-apple-darwin.tar.gz"
FD_URL="https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-aarch64-apple-darwin.tar.gz"
RG_URL="https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-aarch64-apple-darwin.tar.gz"
BAT_URL="https://github.com/sharkdp/bat/releases/download/v0.25.0/bat-v0.25.0-aarch64-apple-darwin.tar.gz"
FZF_URL="https://github.com/junegunn/fzf/releases/download/v0.61.2/fzf-0.61.2-darwin_arm64.tar.gz"
LAZYGIT_URL="https://github.com/jesseduffield/lazygit/releases/download/v0.49.0/lazygit_0.49.0_Darwin_arm64.tar.gz"
YAZI_URL="https://github.com/sxyazi/yazi/releases/download/v25.4.8/yazi-aarch64-apple-darwin.zip"
SAD_URL="https://github.com/ms-jpq/sad/releases/download/v0.4.32/aarch64-apple-darwin.zip"
DIFFTASTIC_URL="https://github.com/Wilfred/difftastic/releases/download/0.63.0/difft-aarch64-apple-darwin.tar.gz"
DELTA_URL="https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-aarch64-apple-darwin.tar.gz"
LSD_URL="https://github.com/lsd-rs/lsd/releases/download/v1.1.5/lsd-v1.1.5-aarch64-apple-darwin.tar.gz"
ZOXIDE_URL="https://github.com/ajeetdsouza/zoxide/releases/download/v0.9.7/zoxide-0.9.7-aarch64-apple-darwin.tar.gz"
FW_URL="https://raw.githubusercontent.com/yilinfang/fw/main/fw"
TMUX_MACOS_BUILDER_URL="https://raw.githubusercontent.com/yilinfang/tmux-macos-builder/refs/heads/main/build.sh"

# Installation tracking variables
UPDATE_SHELL_CONFIGURATION=0

# Function to display menu and get user selection
show_menu() {
  echo "Select tools to install:"
  echo "1. Neovim"
  echo "2. Node.js"
  echo "3. Zellij"
  echo "4. fd"
  echo "5. ripgrep"
  echo "6. bat"
  echo "7. fzf"
  echo "8. lazygit"
  echo "9. Yazi"
  echo "10. sad"
  echo "11. difftastic"
  echo "12. delta"
  echo "13. fw"
  echo "14. tmux"
  echo "15. lsd"
  echo "16. zoxide"
  echo "a. Install all"
  echo "i. Initialize shell configuration"

  read -p "Your choice: " CHOICE
}

# Installation functions
install_nvim() {
  echo "Installing Neovim..."
  rm -rf "$NEOVIM_DIR"
  mkdir -p "$NEOVIM_DIR"
  curl -L "$NEOVIM_URL" -o "$TEMP_DIR/nvim.tar.gz"
  tar -xzf "$TEMP_DIR/nvim.tar.gz" -C "$NEOVIM_DIR" --strip-components=1
  echo "Neovim installed in $NEOVIM_DIR."
  UPDATE_SHELL_CONFIGURATION=1
}

install_nodejs() {
  echo "Installing Node.js..."
  rm -rf "$NODEJS_DIR"
  mkdir -p "$NODEJS_DIR"
  curl -L "$NODEJS_URL" -o "$TEMP_DIR/node.tar.gz"
  tar -xzf "$TEMP_DIR/node.tar.gz" -C "$NODEJS_DIR" --strip-components=1
  echo "Node.js installed in $NODEJS_DIR."
  UPDATE_SHELL_CONFIGURATION=1
}

install_zellij() {
  echo "Installing Zellij..."
  rm -rf "$ZELLIJ_DIR"
  mkdir -p "$ZELLIJ_DIR"
  curl -L "$ZELLIJ_URL" -o "$TEMP_DIR/zellij.tar.gz"
  tar -xzf "$TEMP_DIR/zellij.tar.gz" -C "$ZELLIJ_DIR"
  ZELLIJ_BINARY=$(find "$ZELLIJ_DIR" -type f -name "zellij" | head -n 1)
  if [ -n "$ZELLIJ_BINARY" ]; then
    # Create a symbolic link to the Zellij binary
    ln -s "$ZELLIJ_DIR/zellij" "$INSTALL_DIR/zellij"
    echo "Created link to Zellij at $INSTALL_DIR/zellij"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: Zellij binary not found in the extracted files."
    return
  fi
}

install_fd() {
  echo "Installing fd..."
  rm -rf "$FD_DIR"
  mkdir -p "$FD_DIR"
  curl -L "$FD_URL" -o "$TEMP_DIR/fd.tar.gz"
  tar -xzf "$TEMP_DIR/fd.tar.gz" -C "$FD_DIR"
  FD_BINARY=$(find "$FD_DIR" -type f -name "fd" | head -n 1)
  if [ -n "$FD_BINARY" ]; then
    # Create a symbolic link to the fd binary
    ln -s "$FD_BINARY" "$INSTALL_DIR/fd"
    echo "Created link to fd at $INSTALL_DIR/fd"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: fd binary not found in the extracted files."
  fi
}

install_ripgrep() {
  echo "Installing ripgrep..."
  rm -rf "$RG_DIR"
  mkdir -p "$RG_DIR"
  curl -L "$RG_URL" -o "$TEMP_DIR/rg.tar.gz"
  tar -xzf "$TEMP_DIR/rg.tar.gz" -C "$RG_DIR"
  RG_BINARY=$(find "$RG_DIR" -type f -name "rg" | head -n 1)
  if [ -n "$RG_BINARY" ]; then
    # Create a symbolic link to the ripgrep binary
    ln -s "$RG_BINARY" "$INSTALL_DIR/rg"
    echo "Created link to ripgrep at $INSTALL_DIR/rg"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: ripgrep binary not found in the extracted files."
  fi
}

install_bat() {
  echo "Installing bat..."
  rm -rf "$BAT_DIR"
  mkdir -p "$BAT_DIR"
  curl -L "$BAT_URL" -o "$TEMP_DIR/bat.tar.gz"
  tar -xzf "$TEMP_DIR/bat.tar.gz" -C "$BAT_DIR"
  BAT_BINARY=$(find "$BAT_DIR" -type f -name "bat" | head -n 1)
  if [ -n "$BAT_BINARY" ]; then
    # Create a symbolic link to the bat binary
    ln -s "$BAT_BINARY" "$INSTALL_DIR/bat"
    echo "Created link to bat at $INSTALL_DIR/bat"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: bat binary not found in the extracted files."
  fi
}

install_fzf() {
  echo "Installing fzf..."
  rm -rf "$FZF_DIR"
  mkdir -p "$FZF_DIR"
  curl -L "$FZF_URL" -o "$TEMP_DIR/fzf.tar.gz"
  tar -xzf "$TEMP_DIR/fzf.tar.gz" -C "$FZF_DIR"
  FZF_BINARY=$(find "$FZF_DIR" -type f -name "fzf" | head -n 1)
  if [ -n "$FZF_BINARY" ]; then
    # Create a symbolic link to the fzf binary
    ln -s "$FZF_DIR/fzf" "$INSTALL_DIR/fzf"
    echo "Created link to fzf at $INSTALL_DIR/fzf"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: fzf binary not found in the extracted files."
  fi
}

install_lazygit() {
  echo "Installing lazygit..."
  rm -rf "$LAZYGIT_DIR"
  mkdir -p "$LAZYGIT_DIR"
  curl -L "$LAZYGIT_URL" -o "$TEMP_DIR/lazygit.tar.gz"
  tar -xzf "$TEMP_DIR/lazygit.tar.gz" -C "$LAZYGIT_DIR"
  LAZYGIT_BINARY=$(find "$LAZYGIT_DIR" -type f -name "lazygit" | head -n 1)
  if [ -n "$LAZYGIT_BINARY" ]; then
    # Create a symbolic link to the lazygit binary
    ln -s "$LAZYGIT_BINARY" "$INSTALL_DIR/lazygit"
    echo "Created link to lazygit at $INSTALL_DIR/lazygit"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: lazygit binary not found in the extracted files."
  fi
}

install_yazi() {
  echo "Installing Yazi..."
  rm -rf "$YAZI_DIR"
  mkdir -p "$YAZI_DIR"
  curl -L "$YAZI_URL" -o "$TEMP_DIR/yazi.zip"
  unzip "$TEMP_DIR/yazi.zip" -d "$YAZI_DIR"
  YAZI_BINARY=$(find "$YAZI_DIR" -type f -name "yazi" | head -n 1)
  if [ -n "$YAZI_BINARY" ]; then
    # Create a symbolic link to the Yazi binary
    ln -s "$YAZI_BINARY" "$INSTALL_DIR/yazi"
    echo "Created link to yazi at $INSTALL_DIR/yazi"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: yazi binary not found in the extracted files."
  fi

  YA_BINARY=$(find "$YAZI_DIR" -type f -name "ya" | head -n 1)
  if [ -n "$YA_BINARY" ]; then
    # Create a symbolic link to the ya binary
    ln -s "$YA_BINARY" "$INSTALL_DIR/ya"
    echo "Created link to ya at $INSTALL_DIR/ya"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: ya binary not found in the extracted files."
  fi
}

install_sad() {
  echo "Installing sad..."
  rm -rf "$SAD_DIR"
  mkdir -p "$SAD_DIR"
  curl -L "$SAD_URL" -o "$TEMP_DIR/sad.zip"
  unzip "$TEMP_DIR/sad.zip" -d "$SAD_DIR"
  SAD_BINARY=$(find "$SAD_DIR" -type f -name "sad" | head -n 1)
  if [ -n "$SAD_BINARY" ]; then
    # Create a symbolic link to the sad binary
    ln -s "$SAD_BINARY" "$INSTALL_DIR/sad"
    echo "Created link to sad at $INSTALL_DIR/sad"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: sad binary not found in the extracted files."
  fi
}

install_diffastic() {
  echo "Installing difftastic..."
  rm -rf "$DIFFTASTIC_DIR"
  mkdir -p "$DIFFTASTIC_DIR"
  curl -L "$DIFFTASTIC_URL" -o "$TEMP_DIR/difftastic.tar.gz"
  tar -xzf "$TEMP_DIR/difftastic.tar.gz" -C "$DIFFTASTIC_DIR"
  DIFFTASTIC_BINARY=$(find "$DIFFTASTIC_DIR" -type f -name "difft" | head -n 1)
  if [ -n "$DIFFTASTIC_BINARY" ]; then
    # Create a symbolic link to the difftastic binary
    ln -s "$DIFFTASTIC_BINARY" "$INSTALL_DIR/difft"
    echo "Created link to difftastic at $INSTALL_DIR/difft"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: difftastic binary not found in the extracted files."
  fi
}

install_delta() {
  echo "Installing delta..."
  rm -rf "$DELTA_DIR"
  mkdir -p "$DELTA_DIR"
  curl -L "$DELTA_URL" -o "$TEMP_DIR/delta.tar.gz"
  tar -xzf "$TEMP_DIR/delta.tar.gz" -C "$DELTA_DIR"
  DELTA_BINARY=$(find "$DELTA_DIR" -type f -name "delta" | head -n 1)
  if [ -n "$DELTA_BINARY" ]; then
    # Create a symbolic link to the delta binary
    ln -s "$DELTA_BINARY" "$INSTALL_DIR/delta"
    echo "Created link to delta at $INSTALL_DIR/delta"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: delta binary not found in the extracted files."
  fi
}

install_lsd() {
  echo "Installing lsd..."
  rm -rf "$LSD_DIR"
  mkdir -p "$LSD_DIR"
  curl -L "$LSD_URL" -o "$TEMP_DIR/lsd.tar.gz"
  tar -xzf "$TEMP_DIR/lsd.tar.gz" -C "$LSD_DIR"
  LSD_BINARY=$(find "$LSD_DIR" -type f -name "lsd" | head -n 1)
  if [ -n "$LSD_BINARY" ]; then
    # Create a symbolic link to the lsd binary
    ln -s "$LSD_BINARY" "$INSTALL_DIR/lsd"
    echo "Created link to lsd at $INSTALL_DIR/lsd"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: lsd binary not found in the extracted files."
  fi
}

install_zoxide() {
  echo "Installing zoxide..."
  rm -rf "$ZOXIDE_DIR"
  mkdir -p "$ZOXIDE_DIR"
  curl -L "$ZOXIDE_URL" -o "$TEMP_DIR/zoxide.tar.gz"
  tar -xzf "$TEMP_DIR/zoxide.tar.gz" -C "$ZOXIDE_DIR"
  ZOXIDE_BINARY=$(find "$ZOXIDE_DIR" -type f -name "zoxide" | head -n 1)
  if [ -n "$ZOXIDE_BINARY" ]; then
    # Create a symbolic link to the zoxide binary
    ln -s "$ZOXIDE_BINARY" "$INSTALL_DIR/zoxide"
    echo "Created link to zoxide at $INSTALL_DIR/zoxide"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: zoxide binary not found in the extracted files."
  fi
}

install_fw() {
  echo "Installing fw..."
  rm -rf "$FW_DIR"
  mkdir -p "$FW_DIR"
  curl -o "$FW_DIR/fw" "$FW_URL"
  ln -s "$FW_DIR/fw" "$INSTALL_DIR/fw"
  chmod +x "$INSTALL_DIR/fw"
  echo "fw installed at $FW_DIR/fw and linked to $INSTALL_DIR/fw"
  UPDATE_SHELL_CONFIGURATION=1
}

install_tmux() {
  echo "Installing tmux..."
  rm -rf "$TMUX_DIR"
  mkdir -p "$TMUX_DIR"
  curl -L "$TMUX_MACOS_BUILDER_URL" -o "$TEMP_DIR/tmux-builder.sh"
  chmod +x "$TEMP_DIR/tmux-builder.sh"
  mkdir -p "$TEMP_DIR/tmux"
  echo y | "$TEMP_DIR/tmux-builder.sh" "$TMUX_DIR" "$TEMP_DIR/tmux" "3.5a"
  TMUX_BINARY=$(find "$TMUX_DIR/bin" -type f -name "tmux" | head -n 1)
  if [ -n "$TMUX_BINARY" ]; then
    # Create a symbolic link to the tmux binary
    ln -s "$TMUX_BINARY" "$INSTALL_DIR/tmux"
    echo "Created link to tmux at $INSTALL_DIR/tmux"
    UPDATE_SHELL_CONFIGURATION=1
  else
    echo "Error: tmux binary not found in the extracted files."
  fi
}

# Create fish shell initialization script
create_shell_init_script() {
  echo "Creating fish shell initialization script..."

  rm -f "$PREFIX/init.fish"

  tee "$PREFIX/init.fish" <<EOF
# nvim-starter environment initialization

# Add binaries to PATH using fish_add_path
fish_add_path -g $INSTALL_DIR

# Set PATH for Neovim if installed
if test -f "$NEOVIM_DIR/bin/nvim"
  fish_add_path -g $NEOVIM_DIR/bin

  # Set EDITOR and VISUAL to nvim
  set -gx EDITOR nvim
  set -gx VISUAL nvim

  # If n is available, use it for nvim
  if not command -v n > /dev/null
    alias n="nvim"
  end
end
EOF

  # If Node.js is installed, ask user for confirmation to add to PATH
  if [ -f "$NODEJS_DIR/bin/node" ]; then

    # Ask user for confirmation to add Node.js to PATH
    read -p "Do you want to add Node.js to PATH? (y/n): " ADD_NODEJS

    if [[ "$ADD_NODEJS" =~ ^[Yy]$ ]]; then
      tee -a "$PREFIX/init.fish" <<EOF
# Set PATH for Node.js if installed
if test -f "$NODEJS_DIR/bin/node"
  fish_add_path -g $NODEJS_DIR/bin
end

EOF
    fi
  fi

  tee -a "$PREFIX/init.fish" <<EOF
# Set BAT_THEME if bat is installed
if test -f "$INSTALL_DIR/bat"
  set -gx BAT_THEME "Solarized (dark)"
end

# Initialize fzf if installed
if test -f "$INSTALL_DIR/fzf"
  fzf --fish | source
end

# Initialize zoxide if installed
if test -f "$INSTALL_DIR/zoxide"
  zoxide init fish | source
end

# Create alias for lsd if installed
if test -f "$INSTALL_DIR/lsd"
  alias ls='lsd --color=always --icon=always --group-directories-first'
  alias l='ls'
  alias la='ls -A'
  alias ll='ls -l --total-size'
  alias lla='ll -A'
  alias lt='ls -l --tree --depth=3 --total-size'
  alias lta='lt -A'
end

# Add yazi binding if yazi is installed and y is available
if test -f "$INSTALL_DIR/yazi"; and not command -v y > /dev/null
  function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi \$argv --cwd-file="\$tmp"
    if test -f "\$tmp"
      set cwd (cat "\$tmp")
      if test -n "\$cwd"; and test "\$cwd" != (pwd)
        cd "\$cwd"
      end
    end
    rm -f "\$tmp"
  end
end

# If g is available, use it for Git
if not command -v g > /dev/null
  alias g="git"
end

# If t is available, use it for tmux
if command -v tmux > /dev/null; and not command -v t > /dev/null
  alias t="tmux"
end

# If ze is available, use it for Zellij
if test -f "$INSTALL_DIR/zellij"; and not command -v ze > /dev/null
  alias ze="zellij"
end

# If lg is available, use it for lazygit
if test -f "$INSTALL_DIR/lazygit"; and not command -v lg > /dev/null
  alias lg="lazygit"
end

EOF

  echo "Fish shell initialization script created at $PREFIX/init.fish"
}

main() {
  # Clean up and create fresh directories
  rm -rf "$TEMP_DIR"
  mkdir -p "$INSTALL_DIR" "$TEMP_DIR"

  # Show menu and process selection
  show_menu

  # Process user selection
  if [[ "$CHOICE" == "a" ]]; then
    install_nvim
    install_nodejs
    install_zellij
    install_fd
    install_ripgrep
    install_bat
    install_fzf
    install_lazygit
    install_yazi
    install_sad
    install_diffastic
    install_delta
    install_fw
    install_tmux
    install_lsd
    install_zoxide
  elif [[ "$CHOICE" == "i" ]]; then
    UPDATE_SHELL_CONFIGURATION=1
  else
    for num in $CHOICE; do
      case $num in
      1) install_nvim ;;
      2) install_nodejs ;;
      3) install_zellij ;;
      4) install_fd ;;
      5) install_ripgrep ;;
      6) install_bat ;;
      7) install_fzf ;;
      8) install_lazygit ;;
      9) install_yazi ;;
      10) install_sad ;;
      11) install_diffastic ;;
      12) install_delta ;;
      13) install_fw ;;
      14) install_tmux ;;
      15) install_lsd ;;
      16) install_zoxide ;;
      *) echo "Invalid option: $num" ;;
      esac
    done
  fi

  # Update fish shell configuration
  if [ $UPDATE_SHELL_CONFIGURATION -eq 1 ]; then
    create_shell_init_script

    # Define fish config file path
    FISH_CONFIG_FILE="$HOME/.config/fish/config.fish"
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    BACKUP_FILE="$HOME/.config/fish/config.fish.bak_$TIMESTAMP"

    # Ensure the directory exists
    mkdir -p "$(dirname "$FISH_CONFIG_FILE")"

    # Check if config.fish exists
    if [ -f "$FISH_CONFIG_FILE" ]; then
      # Backup the existing config.fish
      cp "$FISH_CONFIG_FILE" "$BACKUP_FILE"
      echo "Backup of config.fish created at $BACKUP_FILE"
    else
      # Create a config.fish file
      touch "$FISH_CONFIG_FILE"
      echo "Created new config.fish at $FISH_CONFIG_FILE"
    fi

    # Add source line if not already present
    if ! grep -q "source $PREFIX/init.fish" "$FISH_CONFIG_FILE"; then
      echo "" >>"$FISH_CONFIG_FILE"
      echo "# pde-starter configuration" >>"$FISH_CONFIG_FILE"
      echo "if test -f $PREFIX/init.fish" >>"$FISH_CONFIG_FILE"
      echo "    source $PREFIX/init.fish" >>"$FISH_CONFIG_FILE"
      echo "end" >>"$FISH_CONFIG_FILE"
      echo "Added initialization script to $FISH_CONFIG_FILE"
    fi
  fi

  # Clean up
  rm -rf "$TEMP_DIR"

  if [ $UPDATE_SHELL_CONFIGURATION -eq 1 ]; then
    echo "Installation complete. Please restart your shell to apply the changes."
  else
    echo "Installation complete."
  fi
}

main "$@"
