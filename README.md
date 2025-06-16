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
- [sd](https://github.com/chmln/sd)
- [Yazi](https://github.com/sxyazi/yazi)

## Requirements

- Git >= 2.19.0
- curl
- Xcode Command Line Tools (MacOS only)

## Motivation

I enjoy coding with my PDE includes Neovim and other useful tools (such as ripgrep, fd, bat and Lazygit) on my Mac. With Homebrew, I can easily manage these dependencies.

However, I came across following issues:

1. I do a lot of development on remote servers, and I often need to set up my PDE from scratch. I do not have root permission on some of these servers, and some package in the repositories are outdated or unavailable.

2. On my local Mac, I used to use Homebrew to manage my PDE's dependencies. However, I find that Homebrew does not allowed me to install a specific version of a package which may caused breaks, as many of the tools are not in stable stage and they are developed rapidly.

To solve these issues, I decided to create a set of scripts that can help me set up my PDE quickly and easily. The scripts will install the dependencies in a local directory, and they will not interfere with the system's package manager.

_**Note**: Git, curl and tmux are not included because they are usually pre-installed and ready-to-use on most servers I use.:D_

## Uninstallation

1. Delete the `~/.pde` directory.
2. Remove any `pde-starter` related entries in `config.fish` or `.bashrc`.
