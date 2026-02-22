#!/bin/bash
# Multi-select tmux session deletion using fzf

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
    exit 0
fi

selected=$(echo "$sessions" | fzf --multi --height=40% --reverse --border \
    --prompt="Select sessions to delete (Tab to multi-select): ")

if [ -z "$selected" ]; then
    echo "No sessions selected."
    exit 0
fi

count=$(echo "$selected" | wc -l)
echo "Sessions to delete ($count):"
echo "$selected" | while read -r line; do
    echo "  - $(echo "$line" | cut -d: -f1)"
done

read -rp "Confirm deletion? (y/N): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "$selected" | while read -r line; do
        session_name=$(echo "$line" | cut -d: -f1)
        tmux kill-session -t "$session_name" && echo "Deleted: $session_name"
    done
else
    echo "Cancelled."
fi
