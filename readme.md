# Dotfiles

Personal dotfiles managed with symlinks for a clean, version-controlled setup.

## Quick Start

```bash
cd ~ && git clone https://github.com/arshvirc/dotfiles.git && cd dotfiles && ./install.sh
source ~/.zshrc
```

To update later, run `dot-update` from anywhere.

## What's Included

### Zsh

- [Oh My Zsh](https://ohmyz.sh/) with Robbyrussell theme
- **Plugins**: git, zsh-autosuggestions, zsh-syntax-highlighting
- **Local overrides**: machine-specific config via `~/.zshrc.local` (gitignored)

### Tmux

- **Mouse support** — click panes, scroll, drag borders to resize
- **Plugins** (via [TPM](https://github.com/tmux-plugins/tpm)): tmux-sensible, [tmux-sessionx](https://github.com/omerxx/tmux-sessionx), tmux-yank
- **Session navigator** — `prefix + o` opens a fuzzy session switcher with tree view

#### Keybindings (prefix: `Ctrl-b`)

| Key | Action |
|-----|--------|
| `prefix + h` | Split horizontal |
| `prefix + v` | Split vertical |
| `prefix + Arrow` | Navigate panes |
| `prefix + x` | Close pane (confirm) |
| `prefix + X` | Close window (confirm) |
| `prefix + o` | Open sessionx popup |
| `prefix + Tab` | Switch to last session |

#### CLI Aliases

| Alias | Description |
|-------|-------------|
| `ts` | Interactive session switcher (fzf) |
| `tds` | Multi-select session deletion (fzf) |
| `tmux-help` | Print quick-reference card in terminal |
| `dot-update` | Pull latest dotfiles and reload shell |

## Repository Structure

```
dotfiles/
├── install.sh              # Installer and symlink manager
├── zsh/
│   └── zshrc               # Main zsh configuration
└── tmux/
    ├── tmux.conf            # Tmux configuration
    └── scripts/
        ├── tmux-sessions.sh       # fzf session switcher
        ├── tmux-delete-sessions.sh # fzf multi-select session deletion
        └── tmux-help.sh           # Quick-reference card
```

## How It Works

The installer (`install.sh`) does the following:

1. Pulls the latest dotfiles (or clones the repo on first run)
2. Installs Oh My Zsh and zsh plugins if missing
3. Backs up any existing `~/.zshrc` and `~/.tmux.conf` before symlinking
4. Installs `fzf` if not present
5. Installs TPM and tmux plugins
6. Symlinks all config files and scripts into place

Existing configurations are never lost — they're backed up to `~/.zshrc.bak` and `~/.tmux.conf.bak`.

## Customization

Add machine-specific settings (PATH overrides, API keys, work aliases) to `~/.zshrc.local`. This file is automatically sourced by the main config but is not tracked by git.

## Prerequisites

- `git`
- `zsh`
- `tmux`
- `curl`

`fzf` is installed automatically by the installer if not already present.

## License

MIT
