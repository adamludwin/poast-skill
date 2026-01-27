#!/bin/bash
# Set up Poast authentication
# Usage: ./poast_setup.sh <token>
#
# This stores your token in ~/.config/poast/token
# Alternatively, set POAST_TOKEN environment variable

set -e

TOKEN="$1"
CONFIG_DIR="$HOME/.config/poast"
CONFIG_FILE="$CONFIG_DIR/token"

if [ -z "$TOKEN" ]; then
  echo "Poast Setup"
  echo "==========="
  echo ""
  echo "1. Log in at https://www.poast.sh/login"
  echo "2. Visit https://www.poast.sh/api/auth/token"
  echo "3. Copy your token and run:"
  echo ""
  echo "   ./poast_setup.sh <your-token>"
  echo ""
  echo "Or set environment variable:"
  echo "   export POAST_TOKEN=\"<your-token>\""
  exit 1
fi

# Create config directory
mkdir -p "$CONFIG_DIR"

# Write token with restricted permissions
echo "$TOKEN" > "$CONFIG_FILE"
chmod 600 "$CONFIG_FILE"

echo "✅ Token saved to $CONFIG_FILE"
echo ""
echo "You're all set! Try posting:"
echo "  ./poast.sh '[{\"type\":\"text\",\"data\":\"Hello from Poast!\"}]'"
