# lazydocker

A TUI for Docker — browse containers, tail logs, restart services, exec into shells without typing `docker compose ...` all day.

Used in the manor-devex multi-clone workspace: keep `lazydocker` open in one pane, switch clones with `dx` in another, and the container list updates automatically.

## Install

```bash
brew install jesseduffield/lazydocker/lazydocker
```

The maintainer's tap is recommended over `homebrew-core` because it tracks releases faster.

## Usage

Two panes (iTerm tabs or tmux splits):

**Pane A — the switcher**
```bash
dx 2     # stop current clone, start manor-devex-2, cd into it
dx       # print the active clone path
```

**Pane B — the log viewer** (leave it open)
```bash
lazydocker
```

When you `dx 3` in Pane A, lazydocker's container list in Pane B repopulates within ~1s with devex-3 services. No need to restart lazydocker.

## Key bindings

| Key          | Action                                             |
|--------------|----------------------------------------------------|
| `↑` `↓` / `j` `k` | Move between containers                       |
| `Tab` / `←` `→`   | Switch panes (containers → logs → stats → config) |
| `enter`      | Focus the log pane for the selected container      |
| `/`          | Filter logs                                        |
| `d` then `d` | Stop the container                                 |
| `r`          | Restart the container                              |
| `E`          | Exec into the container (shell)                    |
| `x`          | Open the menu of all available commands            |
| `?`          | Help — shows every keybind                         |
| `q`          | Quit                                               |

## Why this setup works

The manor-devex workspace rule (`/Users/sauloxd/workspace/CLAUDE.md`) says only **one** clone's compose stack can run at a time — they share ports and container names. That means:

- There's nothing to "toggle" inside lazydocker — only one clone ever has running containers.
- The real switch is `docker compose down` on the old + `docker compose up -d` on the new, which `dx` handles.
- lazydocker just polls the Docker daemon, so it reflects whatever's currently up.

## The `dx` function

Defined in `shell/zshrc`. Source of truth lives there; this is a pointer.

```
dx <N>    # switch to manor-devex-<N>
dx        # print active clone
```

Reads/writes `/Users/sauloxd/workspace/.active-clone` to track which clone is running.
