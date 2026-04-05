# Dotfiles Configuration Guide

This file provides context for Claude Code when working with this dotfiles repository.

## Core Principles

**All configuration should be versioned in this dotfiles repository.** Never edit config files directly in their target locations (e.g., `~/.config/`). Instead:

1. Edit the source file in `~/.dotfiles/`
2. Run `./install` to apply changes via symlinks

**When installing software, ALWAYS fetch and follow the official docs/webpage first.** Never rely on LLM training data for installation instructions — it may be outdated. If official docs are found, follow them directly without asking for consent. Only ask the user for consent on installation direction when no official docs are available and you'd be relying on training data.

## Repository Structure

```
~/.dotfiles/
├── apps/                    # Application configs
│   ├── emacs/              # Doom Emacs (init.el, packages.el, config.org)
│   ├── git/                # Git config and global gitignore
│   ├── karabiner/          # Karabiner-Elements key remapping
│   ├── tmux/               # Tmux configuration
│   └── vim/                # Vim/Neovim configuration
├── shell/                   # Shell configs (zshrc, bashrc)
├── .claude/                # Claude Code config (agents, commands)
├── install                  # Dotbot installation script
└── install.conf.yaml        # Symlink definitions
```

## How Dotbot Works

This repo uses [Dotbot](https://github.com/anishathalye/dotbot) to manage symlinks.

### Adding New Config

1. Create the config file under the appropriate `apps/` subdirectory
2. Add a link entry in `install.conf.yaml`:
   ```yaml
   - link:
       ~/.config/newapp/config: apps/newapp/config
   ```
3. Run `./install`

### Glob Patterns

For directories with multiple files:
```yaml
- link:
    ~/.config/app/:
      path: apps/app/**
      glob: true
      create: true
```

## Doom Emacs Setup

### Location

- Source files: `~/.dotfiles/apps/emacs/`
- Target (symlinked): `~/.config/doom/`

### Key Files

| File | Purpose |
|------|---------|
| `init.el` | Enables Doom modules (completion, UI, languages, tools) |
| `packages.el` | Declares external packages to install |
| `config.org` | Literate config (tangled to `config.el`) |

### Enabled Modules (Notable)

- **Completion:** company, vertico
- **UI:** doom, treemacs, workspaces, vc-gutter
- **Editor:** evil, multiple-cursors, snippets
- **Tools:** direnv, lsp, magit, tree-sitter
- **Languages:** Ruby (+rails +lsp), JavaScript, JSON, YAML, Markdown, LaTeX, shell
- **Terminal:** vterm

### Common Operations

```bash
# After editing init.el or packages.el
doom sync

# Rebuild Doom (after major changes)
doom build

# Upgrade Doom and packages
doom upgrade

# Doctor (troubleshooting)
doom doctor
```

### Adding a Package

1. Edit `~/.dotfiles/apps/emacs/packages.el`:
   ```elisp
   (package! package-name)
   ;; Or from GitHub:
   (package! package-name :recipe (:host github :repo "user/repo"))
   ```
2. Run `doom sync`
3. Configure in `config.org` or create a section for it

### Config Style

This setup uses **literate configuration** via `config.org`. The org file gets tangled to `config.el`. When adding configuration:

- Add to `config.org` with proper org headers
- Or edit `config.el` directly (but it may be overwritten on tangle)

## Claude Code Config

Claude Code settings are also managed here:

- `~/.dotfiles/.claude/agents/` - Custom agent definitions
- `~/.dotfiles/.claude/commands/` - Custom slash commands
- `~/.dotfiles/.claude/CLAUDE.md` - This file (symlinked to `~/.claude/CLAUDE.md`)

## Agent Routing

When working on software tasks, prefer delegating to BMC specialist agents:
- `bmc-backend` — APIs, databases, business logic
- `bmc-frontend` — UI, components, styling, accessibility
- `bmc-devops` — Infrastructure, CI/CD, deployments
- `bmc-security` — Security review, threat modeling
- `bmc-code-review` — PR review, code quality
- `bmc-testing` — Tests, debugging, QA
- `bmc-product` — Requirements, specs, prioritization
- `bmc-ai-agents` — Agent architecture, MCP, skills
- `final-work-reviewer` — Final verification

Pick the most appropriate agent based on the task. Use multiple agents in parallel when the task spans domains.

## Current Symlinks

| Target | Source |
|--------|--------|
| `~/.zshrc` | `shell/zshrc` |
| `~/.bashrc` | `shell/bashrc` |
| `~/.gitconfig` | `apps/git/gitconfig` |
| `~/.gitignore_global` | `apps/git/gitignore_global` |
| `~/.config/doom/*` | `apps/emacs/**` |
| `~/.config/karabiner/karabiner.json` | `apps/karabiner/karabiner.json` |
| `~/.tmux.conf.local` | `apps/tmux/tmux.conf.local` |
| `~/.claude/agents` | `.claude/agents` |
| `~/.claude/commands` | `.claude/commands` |
| `~/.claude/CLAUDE.md` | `.claude/CLAUDE.md` |
