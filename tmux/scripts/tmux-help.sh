#!/bin/bash
# Quick-reference card for custom tmux setup

BOLD='\033[1m'
DIM='\033[2m'
CYAN='\033[36m'
YELLOW='\033[33m'
GREEN='\033[32m'
RESET='\033[0m'

echo ""
echo -e "${BOLD}${CYAN}  tmux quick reference${RESET}"
echo -e "${DIM}  ────────────────────────────────────────${RESET}"
echo ""

echo -e "${BOLD}${YELLOW}  Prefix: Ctrl-b${RESET}"
echo ""

echo -e "${BOLD}  Splits & Panes${RESET}"
echo -e "  ${GREEN}prefix + h${RESET}       Split horizontal"
echo -e "  ${GREEN}prefix + v${RESET}       Split vertical"
echo -e "  ${GREEN}prefix + Arrow${RESET}   Navigate panes"
echo -e "  ${GREEN}prefix + x${RESET}       Close pane (confirm)"
echo -e "  ${GREEN}prefix + X${RESET}       Close window (confirm)"
echo -e "  ${DIM}  Mouse: click panes, scroll, drag borders${RESET}"
echo ""

echo -e "${BOLD}  Sessions${RESET}"
echo -e "  ${GREEN}prefix + o${RESET}       Open sessionx (fuzzy session navigator)"
echo -e "  ${GREEN}prefix + Tab${RESET}     Switch to last session"
echo ""

echo -e "${BOLD}  Inside sessionx${RESET}"
echo -e "  ${GREEN}Ctrl-t${RESET}           Tree view (sessions/windows hierarchy)"
echo -e "  ${GREEN}Ctrl-w${RESET}           Window mode"
echo -e "  ${GREEN}Ctrl-d${RESET}           Delete session"
echo -e "  ${DIM}  Type to fuzzy search, Enter to select${RESET}"
echo ""

echo -e "${BOLD}  CLI aliases${RESET}"
echo -e "  ${GREEN}ts${RESET}               Interactive session switcher (fzf)"
echo -e "  ${GREEN}tds${RESET}              Multi-select session deletion (fzf)"
echo -e "  ${GREEN}tmux-help${RESET}        This reference card"
echo ""

echo -e "${BOLD}  Plugins${RESET}"
echo -e "  ${DIM}tpm, tmux-sensible, tmux-sessionx, tmux-yank${RESET}"
echo ""
