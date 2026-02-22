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

echo "✅ Setup complete! Run 'source ~/.zshrc' or type 'dot-update'."