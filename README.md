# Lazyvim-starters

Scripts used for setting up [Lazyvim](https://www.lazyvim.org/) development environment.

**No root permission needed and has very small influence on local dependencies.**

The following tools will be installed:

- [Neovim](https://neovim.io/)
- [Node.js](https://nodejs.org/)
- [Oh my tmux!](https://github.com/gpakosz/.tmux)
- [fd](https://github.com/sharkdp/fd)
- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fzf](https://github.com/junegunn/fzf)
- [Lazygit](https://github.com/jesseduffield/lazygit)

Please refer to the scripts for detailed information.

## Requirements

- Git >= 2.19.0
- A **C** compiler for _nvim-treesitter_
- curl
- tmux >= 2.6 for _Oh my tmux!_ (optional)

## Motivation

I enjoy coding with Neovim using Lazyvim on my Mac. Brew can easily manage the dependencies.

However, I failed to rebuild the development environment on a server where the packages in the repository were either outdated or missing.

Thus, I started building these scripts. I decided to open source them as I found them quite useful.

_Git, C compiler, curl, and tmux are not provided because I find that they are usually either ready to use or up-to-date on most servers I use. :D_
