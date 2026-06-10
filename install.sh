#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "Checking for updates..."
# 1. Update/Clone Logic
if [ -d "$DOTFILES_DIR/.git" ]; then
    cd "$DOTFILES_DIR" && git pull
else
    git clone https://github.com/arshvirc/dotfiles.git "$DOTFILES_DIR"
    cd "$DOTFILES_DIR"
fi

# 2. Install Oh My Zsh if missing
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 3. Install Plugins if missing
echo "Checking plugins..."
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# 4. SAFETY CHECK: Backup existing .zshrc to .zshrc.local
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    echo "Found existing .zshrc. Migrating contents to .zshrc.local..."
    cat "$HOME/.zshrc" >> "$HOME/.zshrc.local"
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
    echo "Original .zshrc backed up to ~/.zshrc.bak"
fi

# 5. Create the Symlink
echo "Linking .zshrc from repo..."
ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

# 6. Ensure .zshrc.local exists
if [ ! -f "$HOME/.zshrc.local" ]; then
    touch "$HOME/.zshrc.local"
fi

# 7. Install fzf if missing
if ! command -v fzf &>/dev/null; then
    echo "Installing fzf..."
    if command -v apt-get &>/dev/null; then
        sudo apt-get install -y fzf
    elif command -v brew &>/dev/null; then
        brew install fzf
    else
        echo "Please install fzf manually: https://github.com/junegunn/fzf"
    fi
fi

# 8. Ghostty support
# On macOS: install the Ghostty app (alongside iTerm2) if missing.
if [ "$(uname)" = "Darwin" ] && command -v brew &>/dev/null; then
    if [ ! -d "/Applications/Ghostty.app" ] && ! brew list --cask ghostty &>/dev/null; then
        echo "Installing Ghostty..."
        brew install --cask ghostty
    fi
fi
# On any machine: make sure the xterm-ghostty terminfo exists, so SSHing in
# from Ghostty doesn't break tmux/vim with "missing or unsuitable terminal".
if ! infocmp xterm-ghostty &>/dev/null; then
    echo "Installing xterm-ghostty terminfo (xterm-256color fallback)..."
    printf 'xterm-ghostty|Ghostty terminal (xterm-256color fallback),\n\tuse=xterm-256color,\n' > /tmp/xterm-ghostty.ti
    tic -x /tmp/xterm-ghostty.ti && rm -f /tmp/xterm-ghostty.ti
fi

# 9. Install TPM (tmux plugin manager) if missing
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing TPM..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# 10. Symlink tmux.conf
if [ -f "$HOME/.tmux.conf" ] && [ ! -L "$HOME/.tmux.conf" ]; then
    echo "Found existing .tmux.conf. Backing up..."
    mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
fi
echo "Linking .tmux.conf from repo..."
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# 11. Symlink tmux scripts
mkdir -p "$HOME/.tmux/scripts"
ln -sf "$DOTFILES_DIR/tmux/scripts/tmux-sessions.sh" "$HOME/.tmux/scripts/tmux-sessions.sh"
ln -sf "$DOTFILES_DIR/tmux/scripts/tmux-delete-sessions.sh" "$HOME/.tmux/scripts/tmux-delete-sessions.sh"
ln -sf "$DOTFILES_DIR/tmux/scripts/tmux-help.sh" "$HOME/.tmux/scripts/tmux-help.sh"

# 12. Install tmux plugins
echo "Installing tmux plugins..."
"$HOME/.tmux/plugins/tpm/bin/install_plugins" 2>/dev/null || true

echo "✅ Setup complete! Run 'source ~/.zshrc' or type 'dot-update'."