#!/bin/bash
# Interactive tmux session switcher using fzf

if ! command -v fzf &>/dev/null; then
    echo "fzf is required. Install it with: sudo apt install fzf"
    exit 1
fi

if ! command -v tmux &>/dev/null; then
    echo "tmux is not installed."
    exit 1
fi

sessions=$(tmux list-sessions 2>/dev/null)

if [ -z "$sessions" ]; then
    echo "No tmux sessions running."
    read -rp "Create a new session? (name or Enter for default): " name
    if [ -n "$name" ]; then
        tmux new-session -s "$name"
    else
        tmux new-session
    fi
    exit 0
fi

selected=$(echo "$sessions" | fzf --height=40% --reverse --border --prompt="Select session: ")

if [ -n "$selected" ]; then
    session_name=$(echo "$selected" | cut -d: -f1)
    if [ -n "$TMUX" ]; then
        tmux switch-client -t "$session_name"
    else
        tmux attach-session -t "$session_name"
    fi
fi
