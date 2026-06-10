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

### Terminal support (iTerm2 + Ghostty)

Works out of the box with both iTerm2 and [Ghostty](https://ghostty.org/):

- On macOS, the installer installs Ghostty via Homebrew (`brew install --cask ghostty`) if it isn't already installed.
- On Linux servers, the installer registers an `xterm-ghostty` terminfo entry (a fallback based on `xterm-256color`), so SSHing in from Ghostty doesn't break tmux/vim with `missing or unsuitable terminal`.
- Tmux is configured for truecolor and OSC 52 clipboard with both terminals, so copy/paste works over SSH.
- The zshrc falls back to `TERM=xterm-256color` if the incoming `TERM` has no terminfo on the machine, so a fresh box is usable even before running the installer.

Optionally, install Ghostty's *full* terminfo on a server (instead of the fallback) by running this from your Mac:

```bash
infocmp -x xterm-ghostty | ssh <host> -- tic -x -
```

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
5. Installs Ghostty on macOS, and the `xterm-ghostty` terminfo everywhere
6. Installs TPM and tmux plugins
7. Symlinks all config files and scripts into place

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
