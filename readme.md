# Dotfiles

My personal dotfiles. Symlinks configuration files to your home directory for a clean, version-controlled setup.

## Installation

Run the installer with:

cd ~ && git clone https://github.com/arshvirc/dotfiles.git && cd dotfiles && ./install.sh

After installation, run `source ~/.zshrc` to apply changes.

## Updates
Simply run `dot-update` from anywhere in your terminal.

## Customization
For machine-specific settings (like Postgres PATHs, API keys, or work aliases), use `~/.zshrc.local`. 
This file is automatically loaded by the main configuration but is ignored by Git to keep your secrets and local paths safe.

## What's Included
- **Oh My Zsh** (Robbyrussell theme)
- **Plugins**: git, zsh-autosuggestions, zsh-syntax-highlighting
- **Zsh Bridge**: Automatic support for local machine overrides.

## License
MIT