#!/usr/bin/env bash

# Set up directories
PREFIX="$HOME/.nvim-starter"

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
FW_DIR="$PREFIX/fw"

# URLs for tools
NEOVIM_URL="https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz"
NODEJS_URL="https://nodejs.org/dist/v22.14.0/node-v22.14.0-linux-x64.tar.xz"
ZELLIJ_URL="https://github.com/zellij-org/zellij/releases/download/v0.42.1/zellij-x86_64-unknown-linux-musl.tar.gz"
FD_URL="https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-musl.tar.gz"
RG_URL="https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz"
BAT_URL="https://github.com/sharkdp/bat/releases/download/v0.25.0/bat-v0.25.0-x86_64-unknown-linux-musl.tar.gz"
FZF_URL="https://github.com/junegunn/fzf/releases/download/v0.61.1/fzf-0.61.1-linux_amd64.tar.gz"
LAZYGIT_URL="https://github.com/jesseduffield/lazygit/releases/download/v0.48.0/lazygit_0.48.0_Linux_x86_64.tar.gz"
YAZI_URL="https://github.com/sxyazi/yazi/releases/download/v25.3.2/yazi-x86_64-unknown-linux-musl.zip"
SAD_URL="https://github.com/ms-jpq/sad/releases/download/v0.4.32/x86_64-unknown-linux-musl.zip"
DIFFTASTIC_URL="https://github.com/Wilfred/difftastic/releases/download/0.63.0/difft-x86_64-unknown-linux-musl.tar.gz"
DELTA_URL="https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-x86_64-unknown-linux-musl.tar.gz"
FW_URL="https://raw.githubusercontent.com/yilinfang/fw/main/fw"

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
  curl -L "$NODEJS_URL" -o "$TEMP_DIR/node.tar.xz"
  tar -xf "$TEMP_DIR/node.tar.xz" -C "$NODEJS_DIR" --strip-components=1
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

# Installation functions
install_fw() {
  echo "Installing fw..."
  rm -rf "$FW_DIR"
  mkdir -p "$FW_DIR"
  curl -o "$FW_DIR/fw" "$FW_URL"
  chmod +x "$FW_DIR/fw"
  ln -s "$FW_DIR/fw" "$INSTALL_DIR/fw"
  echo "fw installed at $FW_DIR/fw and linked to $INSTALL_DIR/fw"
  UPDATE_SHELL_CONFIGURATION=1
}

create_shell_init_script() {
  echo "Creating bash shell initialization script..."

  rm -f "$PREFIX/init.sh"

  tee "$PREFIX/init.sh" <<EOF
# nvim-starter environment initialization

# Add binaries to PATH
export PATH=$INSTALL_DIR:\$PATH

# Set PATH for Neovim if installed
if [ -f "$NEOVIM_DIR/bin/nvim" ]; then
  export PATH="$NEOVIM_DIR/bin:\$PATH"

  # Set EDITOR and VISUAL to nvim
  export EDITOR="nvim"
  export VISUAL="nvim"

  # If n is available, use it for nvim
  if [ ! \$(command -v n >/dev/null) ]; then
    alias n="nvim"
  fi
fi

EOF

  # If Node.js is installed, ask user for confirmation to add to PATH
  if [ -f "$NODEJS_DIR/bin/node" ]; then

    # Ask user for confirmation to add Node.js to PATH
    read -p "Do you want to add Node.js to PATH? (y/n): " ADD_NODEJS

    if [[ "$ADD_NODEJS" =~ ^[Yy]$ ]]; then
      tee -a "$PREFIX/init.sh" <<EOF
# Set PATH for Node.js if installed
if [ -f "$NODEJS_DIR/bin/node" ]; then
  export PATH="$NODEJS_DIR/bin:\$PATH"
fi

EOF
    fi
  fi

  tee -a "$PREFIX/init.sh" <<EOF
# Initialize fzf if installed
if [ -f "$INSTALL_DIR/fzf" ]; then
  eval "\$(fzf --bash)"
fi

# Add yazi binding if yazi is installed and y is available
if [[ -f "$INSTALL_DIR/yazi" && ! \$(command -v y >/dev/null) ]]; then
  function y() {
    local tmp="\$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "\$@" --cwd-file="\$tmp"
    if cwd="\$(command cat -- "\$tmp")" && [ -n "\$cwd" ] && [ "\$cwd" != "\$PWD" ]; then
      builtin cd -- "\$cwd"
    fi
    rm -f -- "\$tmp"
  }
fi

# If g is available, use it for Git
if ! command -v g >/dev/null 2>&1; then
  alias g="git"
fi

# If t is available, use it for tmux
if ! command -v t >/dev/null 2>&1; then
  alias t="tmux"
fi

# If ze is available, use it for Zellij
if [[ -f "$INSTALL_DIR/zellij" && ! \$(command -v ze >/dev/null) ]]; then
  alias ze="zellij"
fi

# If lg is available, use it for lazygit
if [[ -f "$INSTALL_DIR/lazygit" && ! \$(command -v lg >/dev/null) ]]; then
  alias lg="lazygit"
fi

EOF

  echo "Bash shell initialization script created at $PREFIX/init.sh"
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
      *) echo "Invalid option: $num" ;;
      esac
    done
  fi

  # Update bash shell configuration
  if [ $UPDATE_SHELL_CONFIGURATION -eq 1 ]; then
    create_shell_init_script

    # Define .bashrc file path
    BASH_CONFIG_FILE="$HOME/.bashrc"
    TIMESTAMP=$(date +%Y%m%d%H%M%S)
    BACKUP_FILE="$HOME/.bashrc.bak_$TIMESTAMP"

    # Ensure the directory exists
    mkdir -p "$(dirname "$BASH_CONFIG_FILE")"

    # Check if .bashrc exists
    if [ -f "$BASH_CONFIG_FILE" ]; then
      # Backup the existing .bashrc
      cp "$BASH_CONFIG_FILE" "$BACKUP_FILE"
      echo "Backup of .bashrc created at $BACKUP_FILE"
    else
      # Create a .bashrc file
      touch "$BASH_CONFIG_FILE"
      echo "Created new .bashrc at $BASH_CONFIG_FILE"
    fi

    # Add source line if not already present
    if ! grep -q "source $PREFIX/init.sh" "$BASH_CONFIG_FILE"; then
      echo "" >>"$BASH_CONFIG_FILE"
      echo "# nvim-starter configuration" >>"$BASH_CONFIG_FILE"
      echo "if [ -f $PREFIX/init.sh ]; then" >>"$BASH_CONFIG_FILE"
      echo "    source $PREFIX/init.sh" >>"$BASH_CONFIG_FILE"
      echo "fi" >>"$BASH_CONFIG_FILE"
      echo "Added initialization script to $BASH_CONFIG_FILE"
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
