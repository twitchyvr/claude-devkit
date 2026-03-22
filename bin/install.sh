#!/usr/bin/env bash
#
# claude-devkit installer
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/twitchyvr/claude-devkit/main/bin/install.sh | bash
#   # or
#   git clone https://github.com/twitchyvr/claude-devkit.git && cd claude-devkit && ./bin/install.sh
#

set -euo pipefail

REPO_URL="https://github.com/twitchyvr/claude-devkit"
INSTALL_DIR="${CLAUDE_DEVKIT_HOME:-$HOME/.claude-devkit}"
BIN_DIR="${HOME}/bin"

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

echo "${CYAN}${BOLD}claude-devkit installer${NC}"
echo ""

# Check prerequisites
if ! command -v claude &>/dev/null; then
    echo "${RED}Error: Claude Code CLI not found.${NC}"
    echo "Install it from: https://claude.ai/claude-code"
    exit 1
fi

if ! command -v git &>/dev/null; then
    echo "${RED}Error: git not found.${NC}"
    exit 1
fi

# Clone or update
if [[ -d "$INSTALL_DIR" ]]; then
    echo "${DIM}Updating existing installation...${NC}"
    git -C "$INSTALL_DIR" pull --rebase --quiet 2>/dev/null || true
else
    echo "${DIM}Cloning claude-devkit...${NC}"
    git clone --depth=1 "$REPO_URL" "$INSTALL_DIR" 2>/dev/null
fi

# Link binaries
mkdir -p "$BIN_DIR"
for tool in devlog-hook ai-review project-brief claude-status; do
    chmod +x "$INSTALL_DIR/bin/$tool"
    ln -sf "$INSTALL_DIR/bin/$tool" "$BIN_DIR/$tool"
done

# Check PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo ""
    echo "${CYAN}Add ~/bin to your PATH by adding this to ~/.zshrc:${NC}"
    echo '  export PATH="$HOME/bin:$PATH"'
fi

echo ""
echo "${GREEN}${BOLD}Installed!${NC} Available commands:"
echo "  ${BOLD}ai-review${NC}       — AI-powered code review from git diff"
echo "  ${BOLD}project-brief${NC}   — AI-generated project overview"
echo "  ${BOLD}devlog-hook${NC}     — Auto-summarize commits to DEVLOG.md"
echo "  ${BOLD}claude-status${NC}   — Starship prompt module for Claude Code"
echo ""
echo "${DIM}Run 'devlog-hook --install-global' to enable auto-journaling for all repos.${NC}"
echo "${DIM}See ${REPO_URL} for Starship integration and configuration.${NC}"
