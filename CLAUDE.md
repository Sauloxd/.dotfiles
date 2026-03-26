# Dotfiles Repository

## How Dotbot Works

This repository uses [Dotbot](https://github.com/anishathalye/dotbot), a tool that bootstraps dotfiles by creating symlinks from your home directory to files in this repo.

### Key Files

- `install` - Bash script that runs Dotbot. Execute `./install` to apply all configurations.
- `install.conf.yaml` - Configuration file defining what gets symlinked and where.
- `dotbot/` - Git submodule containing the Dotbot tool.

### Configuration Directives

The `install.conf.yaml` supports these directives:

1. **defaults** - Set default options for other directives (e.g., `relink: true`, `force: true`)
2. **clean** - Remove dead symlinks from specified directories
3. **link** - Create symlinks (destination: source format)
4. **shell** - Run shell commands during installation

### How Links Work

```yaml
- link:
    ~/.zshrc: shell/zshrc           # Simple: ~/.zshrc -> shell/zshrc
    ~/.config/doom/:                 # Extended: with options
      path: apps/emacs/**
      glob: true
      create: true
```

- Destination (left): absolute path in home directory
- Source (right): relative path from this repo

## Repository Structure

```
.dotfiles/
├── apps/                    # Application-specific configs
│   ├── emacs/              # Doom Emacs config
│   ├── git/                # Git config and global gitignore
│   ├── iterm/              # iTerm2 settings
│   ├── tmux/               # Tmux configuration
│   └── vim/                # Vim configuration
├── bin/                     # Custom scripts (not currently symlinked)
├── shell/                   # Shell configs (bashrc, zshrc, etc.)
├── dotbot/                  # Dotbot submodule
├── install                  # Installation script
└── install.conf.yaml        # Dotbot configuration
```

## How to Update install.conf.yaml

### Adding a New Symlink

Add an entry under the `link` section:

```yaml
- link:
    ~/.newconfig: path/to/source
```

### Adding a New App Config

1. Create the directory under `apps/` (e.g., `apps/newapp/`)
2. Add your config files there
3. Add link entry in `install.conf.yaml`:

```yaml
- link:
    ~/.newapprc: apps/newapp/config
```

### Using Glob Patterns

For directories with multiple files:

```yaml
- link:
    ~/.config/newapp/:
      path: apps/newapp/**
      glob: true
      create: true    # Creates parent directories if needed
```

### Running Shell Commands

Add setup commands under the `shell` section:

```yaml
- shell:
  - [command here, Human-readable description]
```

### After Changes

Run `./install` to apply. The script is idempotent - safe to run multiple times.

## Current Symlinks

| Destination | Source |
|-------------|--------|
| `~/.hushlogin` | `shell/hushlogin` |
| `~/.bashrc` | `shell/bashrc` |
| `~/.ubuntu_bashrc` | `shell/ubuntu_bashrc` |
| `~/.zshrc` | `shell/zshrc` |
| `~/.tmux.conf.local` | `apps/tmux/tmux.conf.local` |
| `~/.gitignore_global` | `apps/git/gitignore_global` |
| `~/.gitconfig` | `apps/git/gitconfig` |
| `~/.config/doom/*` | `apps/emacs/**` (glob) |
| `~/.config/karabiner/karabiner.json` | `apps/karabiner/karabiner.json` |
| `~/.claude/agents` | `.claude/agents` |
| `~/.claude/commands` | `.claude/commands` |

## Files NOT Currently Symlinked

These files exist in the repo but are not yet referenced in `install.conf.yaml`:

### Documentation
- `README.org` - Root documentation about setup instructions
- `apps/tmux/README.org` - Tmux configuration docs and tips

### Vim/Neovim (Planned)
- `apps/vim/.vimrc` - Basic vim config (87 lines, minimal plugins)
- `apps/vim/init.vim` - Full Neovim config (279 lines with plugins)

**Note:** These vim configs are kept for future neovim installation. When ready to use, add to `install.conf.yaml`:
```yaml
- link:
    ~/.vimrc: apps/vim/.vimrc
    ~/.config/nvim/init.vim: apps/vim/init.vim
```

### Custom CLI Scripts
- `bin/fl` - Fastlaw CLI for connecting to staging/production Kubernetes pods
- `shell/completions/_fl` - Zsh completion for the fl command

### Empty Directories
- `apps/iterm/` - Currently empty, was cleaned up
