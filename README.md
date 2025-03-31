# nvim-starter

Scripts for setting up [Neovim](https://neovim.io/) ([LazyVim](https://www.lazyvim.org/)) develop environment.

**No root permissions are required, and the setup has minimal impact on local dependencies.**

The following tools will be installed:

- [bat](https://github.com/sharkdp/bat)
- [delta](https://github.com/dandavison/delta)
- [difftastic](https://github.com/Wilfred/difftastic)
- [fd](https://github.com/sharkdp/fd)
- [fzf](https://github.com/junegunn/fzf)
- [fw](https://github.com/yilinfang/fw)
- [Lazygit](https://github.com/jesseduffield/lazygit)
- [Neovim](https://neovim.io/)
- [Node.js](https://nodejs.org/) (required for many language servers)
- [Oh My Tmux!](https://github.com/gpakosz/.tmux)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [SAD!](https://github.com/ms-jpq/sad)
- [Yazi](https://github.com/sxyazi/yazi)
- [Zellij](https://zellij.dev/)

Please refer to the scripts for detailed installation instructions.

**Important:** Make sure to back up your existing configurations for Neovim, tmux, and other tools before running the scripts.

## Requirements

- Git >= 2.19.0
- A **C** compiler (required for _nvim-treesitter_)
- curl
- tmux (optional)

## Motivation

I enjoy coding with Neovim and other useful tools (such as Zellij, bat, and Lazygit) on my Mac. Using Homebrew, I can easily manage these dependencies.

However, I struggled to recreate the same development environment on a server where the repository packages were either outdated or unavailable.

This inspired me to create these scripts. I decided to open-source them because I found them to be quite useful.

_Note: Git, a C compiler, curl, and tmux are not included in this setup because they are usually pre-installed or up-to-date on most servers._

## Uninstallation

1. Run `cleanup-config-unix.sh` to remove the configurations.
2. Delete the `~/.nvim-starter` directory.
3. Remove any nvim-starter related entries in `~/.zshrc` or `~/.bashrc`.
