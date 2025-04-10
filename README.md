# PDE-starter

Bootstrap scripts for setting up [Neovim](https://neovim.io/)-based PDE([Personalized Development Environment](https://youtu.be/QMVIJhC9Veg?si=VgJQLBVTIYmNjVSD)).

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
- [Node.js](https://nodejs.org/) (required for many plugins and language servers)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [SAD!](https://github.com/ms-jpq/sad)
- [Yazi](https://github.com/sxyazi/yazi)
- [Zellij](https://zellij.dev/)

The following configurations will be set up:

- [Neovim](https://github.com/yilinfang/nvim)
- [Zellij](https//github.com/yilinfang/zellij)
- [Yazi](https://github.com/yilinfang/yazi)
- [Tmux](https://github.com/yilinfang/.tmux)

Please refer to the scripts for detailed installation instructions.

**Important:** Make sure to back up your existing configurations for Neovim, tmux, and other tools before running the scripts.

## Requirements

- Git >= 2.19.0
- A **C** compiler (required for _nvim-treesitter_)
- curl
- tmux (optional)

## Motivation

I enjoy coding with my PDE includes Neovim and other useful tools (such as Zellij, bat, and Lazygit) on my Mac. With homebrew, I can easily manage these dependencies.

However, I struggled to recreate the PDE on a server where the repository packages were either outdated or unavailable.

This inspired me to create these scripts. I decided to open-source them because I found them to be quite useful.

_**Note**: Git, C compiler, curl, and tmux are not included in this setup because they are usually pre-installed and up-to-date on most servers I use._

## Uninstallation

1. Run `cleanup-config-unix.sh` to remove the configurations.
2. Delete the `~/.pde` directory.
3. Remove any pde-starter related entries in `config.fish` or `.bashrc`.
