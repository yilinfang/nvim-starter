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

NVIM_CONFIG_DIR="$HOME/.config/nvim"
TMUX_CONFIG_DIR="$HOME/.config/tmux"
ZELLIJ_CONFIG_DIR="$HOME/.config/zellij"

# URLs for tools
NEOVIM_URL="https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-macos-arm64.tar.gz"
NODEJS_URL="https://nodejs.org/dist/v22.14.0/node-v22.14.0-darwin-arm64.tar.gz"
ZELLIJ_URL="https://github.com/zellij-org/zellij/releases/download/v0.41.2/zellij-aarch64-apple-darwin.tar.gz"
FD_URL="https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-aarch64-apple-darwin.tar.gz"
RG_URL="https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-aarch64-apple-darwin.tar.gz"
BAT_URL="https://github.com/sharkdp/bat/releases/download/v0.25.0/bat-v0.25.0-aarch64-apple-darwin.tar.gz"
FZF_URL="https://github.com/junegunn/fzf/releases/download/v0.60.3/fzf-0.60.3-darwin_arm64.tar.gz"
LAZYGIT_URL="https://github.com/jesseduffield/lazygit/releases/download/v0.48.0/lazygit_0.48.0_Darwin_arm64.tar.gz"
YAZI_URL="https://github.com/sxyazi/yazi/releases/download/v25.3.2/yazi-aarch64-apple-darwin.zip"
SAD_URL="https://github.com/ms-jpq/sad/releases/download/v0.4.32/aarch64-apple-darwin.zip"
DIFFTASTIC_URL="https://github.com/Wilfred/difftastic/releases/download/0.63.0/difft-aarch64-apple-darwin.tar.gz"

# Configuration repositories
NVIM_CONFIG_REPO="https://github.com/yilinfang/nvim.git"
TMUX_CONFIG_REPO="https://github.com/yilinfang/tmux.git"
ZELLIJ_CONFIG_REPO="https://github.com/yilinfang/zellij.git"

# Installation tracking variables
UPDATE_SHELL_CONFIGURATION=0

# Function to display menu and get user selection
show_menu() {
  echo "Select tools to install (enter numbers separated by space, or use letter 't', 'z', 'a' for tool bundle):"
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
  echo "13. Neovim config"
  echo "14. tmux config"
  echo "15. Zellij config"
  echo "t. Tool bundle with Oh my tmux!"
  echo "z. Tool bundle with Zellij"
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

  # Create a wrapper script to launch Neovim with the isolated Node.js environment
  tee "$INSTALL_DIR/nvim" <<EOF
#!/usr/bin/env bash

if ! command -v node >/dev/null 2>&1; then
  export PATH=$NODEJS_DIR/bin:\$PATH
fi

exec $NEOVIM_DIR/bin/nvim "\$@"
EOF

  chmod +x "$INSTALL_DIR/nvim"
  echo "Created wrapper script for Neovim at $INSTALL_DIR/nvim"
  UPDATE_SHELL_CONFIGURATION=1
}

install_nodejs() {
  echo "Installing Node.js..."
  rm -rf "$NODEJS_DIR"
  mkdir -p "$NODEJS_DIR"
  curl -L "$NODEJS_URL" -o "$TEMP_DIR/node.tar.gz"
  tar -xzf "$TEMP_DIR/node.tar.gz" -C "$NODEJS_DIR" --strip-components=1
  echo "Node.js installed in $NODEJS_DIR. It will not be added to the system PATH. You have to do it yourself, if you needed."
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

install_nvim_config() {
  echo "Installing Neovim configuration..."
  rm -rf "$NVIM_CONFIG_DIR"
  git clone "$NVIM_CONFIG_REPO" "$NVIM_CONFIG_DIR"
}

install_tmux_config() {
  echo "Installing tmux configuration..."
  rm -rf "$TMUX_CONFIG_DIR"
  git clone "$TMUX_CONFIG_REPO" "$TMUX_CONFIG_DIR"
  ln -s "$TMUX_CONFIG_DIR/.tmux.conf" "$TMUX_CONFIG_DIR/tmux.conf"
  ln -s "$TMUX_CONFIG_DIR/.tmux.conf.local" "$TMUX_CONFIG_DIR/tmux.conf.local"
}

install_zellij_config() {
  echo "Installing Zellij configuration..."
  rm -rf "$ZELLIJ_CONFIG_DIR"
  git clone "$ZELLIJ_CONFIG_REPO" "$ZELLIJ_CONFIG_DIR"
}

# Create fish shell initialization script
create_shell_init_script() {
  echo "Creating fish shell initialization script..."

  rm -f "$PREFIX/init.fish"

  tee "$PREFIX/init.fish" <<EOF
# nvim-starter environment initialization

# Add binaries to PATH using fish_add_path
fish_add_path -g $INSTALL_DIR

# Set EDITOR and VISUAL to nvim if installed
if test -f "$INSTALL_DIR/nvim"
  set -gx EDITOR nvim
  set -gx VISUAL nvim
end

# Initialize fzf if installed
if test -f "$INSTALL_DIR/fzf"
  fzf --fish | source
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

# If n is available, use it for Neovim
if test -f "$INSTALL_DIR/nvim"; and not command -v n > /dev/null
  alias n="nvim"
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
    install_nvim_config
    install_tmux_config
    install_zellij_config
  elif [[ "$CHOICE" == "t" ]]; then
    install_nvim
    install_nodejs
    install_fd
    install_ripgrep
    install_bat
    install_nvim
    install_lazygit
    install_yazi
    install_sad
    install_diffastic
    install_nvim_config
    install_tmux_config
  elif [[ "$CHOICE" == "z" ]]; then
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
    install_nvim_config
    install_zellij_config
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
      13) install_nvim_config ;;
      14) install_tmux_config ;;
      15) install_zellij_config ;;
      *) echo "Invalid option: $num" ;;
      esac
    done
  fi

  # Update fish shell configuration
  if [ $UPDATE_SHELL_CONFIGURATION -eq 1 ]; then
    create_shell_init_script

    # Define fish config file path
    FISH_CONFIG_FILE="$HOME/.config/fish/config.fish"
    BACKUP_FILE="$HOME/.config/fish/config.fish.bak"

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
      echo "# nvim-starter configuration" >>"$FISH_CONFIG_FILE"
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
