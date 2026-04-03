#!/bin/bash
# Install help_claude cheat sheet command
# Usage: curl -fsSL https://raw.githubusercontent.com/JPMasters-AUS/help_claude_cheatsheet/main/install.sh | bash

set -e

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_URL="https://raw.githubusercontent.com/JPMasters-AUS/help_claude_cheatsheet/main/help_claude"

echo "Installing help_claude..."

# Create install directory if needed
mkdir -p "$INSTALL_DIR"

# Download the script
if command -v curl &>/dev/null; then
  curl -fsSL "$SCRIPT_URL" -o "$INSTALL_DIR/help_claude"
elif command -v wget &>/dev/null; then
  wget -qO "$INSTALL_DIR/help_claude" "$SCRIPT_URL"
else
  echo "Error: curl or wget required"
  exit 1
fi

# Make executable
chmod +x "$INSTALL_DIR/help_claude"

# Check if install dir is in PATH
if ! echo "$PATH" | tr ':' '\n' | grep -q "$INSTALL_DIR"; then
  SHELL_RC="$HOME/.zshrc"
  [ -f "$HOME/.bashrc" ] && [ ! -f "$HOME/.zshrc" ] && SHELL_RC="$HOME/.bashrc"

  echo "" >> "$SHELL_RC"
  echo "# Added by help_claude installer" >> "$SHELL_RC"
  echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$SHELL_RC"

  echo "Added $INSTALL_DIR to PATH in $SHELL_RC"
  echo "Run: source $SHELL_RC  (or open a new terminal)"
fi

echo ""
echo "Done! Try it:"
echo "  help_claude          Show full cheat sheet"
echo "  help_claude resume   How to resume sessions"
echo "  help_claude keys     Keyboard shortcuts"
echo "  help_claude tips     Beginner tips"
