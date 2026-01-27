#!/bin/bash
# Update post visibility
# Usage: ./poast_update.sh <post_id> <visibility>
#
# Examples:
#   ./poast_update.sh "post-uuid" "public"
#   ./poast_update.sh "post-uuid" "secret"

set -e

# Load auth helper
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_auth.sh"
require_token

POST_ID="$1"
VISIBILITY="$2"

if [ -z "$POST_ID" ] || [ -z "$VISIBILITY" ]; then
  echo "Usage: ./poast_update.sh <post_id> <visibility>"
  exit 1
fi

curl -s -X PATCH "https://www.poast.sh/api/posts/$POST_ID" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "{\"visibility\": \"$VISIBILITY\"}"
