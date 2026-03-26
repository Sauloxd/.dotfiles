# Dotfiles

Personal dotfiles managed with [Dotbot](https://github.com/anishathalye/dotbot).

> **Note:** This setup is designed for **macOS only**.

## Quick Start

```bash
git clone --recursive https://github.com/YOUR_USERNAME/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
```

## Configured Applications

| Application | Description |
|-------------|-------------|
| **Doom Emacs** | Emacs configuration framework with Evil mode, LSP, and more |
| **Git** | Global gitconfig and gitignore |
| **Karabiner-Elements** | Keyboard customization and remapping |
| **Tmux** | Terminal multiplexer configuration |
| **Vim** | Basic Vim/Neovim configuration |
| **Zsh** | Z shell configuration |
| **Bash** | Bash shell configuration |
| **Claude Code** | AI coding assistant configuration (agents, commands) |

## Prerequisites

Before running `./install`, ensure you have:

- [Emacs 29+](https://www.gnu.org/software/emacs/) with native compilation (for Doom Emacs)
- [Doom Emacs](https://github.com/doomemacs/doomemacs)
- [Oh My Zsh](https://ohmyz.sh/)
- [tmux](https://github.com/tmux/tmux) + [Oh My Tmux](https://github.com/gpakosz/.tmux)
- [Karabiner-Elements](https://karabiner-elements.pqrs.org/)

## Usage

After making changes to config files in this repository:

```bash
./install
```

For Doom Emacs changes:

```bash
doom sync
```

## Structure

```
.dotfiles/
├── apps/
│   ├── emacs/          # Doom Emacs config
│   ├── git/            # Git config
│   ├── karabiner/      # Karabiner-Elements
│   ├── tmux/           # Tmux config
│   └── vim/            # Vim config
├── shell/              # Shell configs (zsh, bash)
├── .claude/            # Claude Code config
├── install             # Dotbot installer
└── install.conf.yaml   # Symlink definitions
```

## License

MIT
