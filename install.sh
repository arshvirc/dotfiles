#!/bin/bash

# Get the location of this script
DOTFILES_DIR=$(pwd)

echo "Starting installation..."

# Link Zsh config
echo "Linking .zshrc"
ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

# Link Git config
if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
    echo "Linking .gitconfig"
    ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
fi

echo "Done! Run 'source ~/.zshrc' to apply changes."
