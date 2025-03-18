# nvim-starter

Scripts used for setting up [Neovim](https://neovim.io/) and [LazyVim](https://www.lazyvim.org/).

**No root permission needed and has very small influence on local dependencies.**

The following tools will be installed:

- [Neovim](https://neovim.io/)
- [Node.js](https://nodejs.org/) (for a lot of lsps)
- [Zellij](https://zellij.dev/)
- [Oh my tmux!](https://github.com/gpakosz/.tmux)
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [bat](https://github.com/sharkdp/bat)
- [fzf](https://github.com/junegunn/fzf)
- [Lazygit](https://github.com/jesseduffield/lazygit)
- [Yazi](https://github.com/sxyazi/yazi)
- [SAD!](https://github.com/ms-jpq/sad)
- [difftastic](https://github.com/Wilfred/difftastic)
- [delta](https://github.com/dandavison/delta)

Please refer to the scripts for detailed information.

**Please backup you configuration of nvim, tmux, etc before running the scripts.**

## Requirements

- Git >= 2.19.0
- A **C** compiler for _nvim-treesitter_
- curl
- tmux (optional)

## Motivation

I enjoy coding with [LazyVim](https://www.lazyvim.org/) and some other useful tools (Zellij, bat, Lazygit...) on my Mac. Brew can easily manage the dependencies.

However, I failed to rebuild the development environment on a server where the packages in the repository were either outdated or missing.

Thus, I started building these scripts. I decided to open source them as I found them quite useful.

_Git, C compiler curl and tmux are not provided because I find that they are usually either ready to use or up-to-date on most servers I use. :D_

## Uninstallation

1. Use `cleanup-config-unix.sh` to remove configurations.
2. Remove directory `~/.nvim-starter`.
3. Remove nvim-starter things in `~/.zshrc` or `~/.bashrc`.
