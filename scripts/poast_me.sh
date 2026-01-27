#!/bin/bash
# Get current user account info
# Usage: ./poast_me.sh

set -e

# Load auth helper
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_auth.sh"
require_token

curl -s "https://www.poast.sh/api/auth/me" \
  -H "Authorization: Bearer $TOKEN"
