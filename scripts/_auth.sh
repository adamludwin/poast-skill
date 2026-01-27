#!/bin/bash
# Shared auth helper - sources POAST_TOKEN from env or config file
# Usage: source _auth.sh

get_token() {
  # 1. Check environment variable first
  if [ -n "$POAST_TOKEN" ]; then
    echo "$POAST_TOKEN"
    return 0
  fi

  # 2. Check config file
  local CONFIG_FILE="$HOME/.config/poast/token"
  if [ -f "$CONFIG_FILE" ]; then
    cat "$CONFIG_FILE"
    return 0
  fi

  # 3. Not found
  return 1
}

require_token() {
  TOKEN=$(get_token)
  if [ -z "$TOKEN" ]; then
    echo "Error: Poast authentication not configured" >&2
    echo "" >&2
    echo "Run setup:" >&2
    echo "  1. Get token at https://www.poast.sh/api/auth/token" >&2
    echo "  2. Run: ./poast_setup.sh <your-token>" >&2
    echo "" >&2
    echo "Or set environment variable:" >&2
    echo "  export POAST_TOKEN=\"<your-token>\"" >&2
    exit 1
  fi
}
