#!/bin/bash
# Post content to Poast
# Usage: ./poast.sh <content_json> [title]
#
# Examples:
#   ./poast.sh '[{"type":"text","data":"Hello!"}]'
#   ./poast.sh '[{"type":"code","data":"const x = 1","language":"javascript"}]' "Code Snippet"

set -e

# Load auth helper
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_auth.sh"
require_token

CONTENT="$1"
TITLE="${2:-}"

if [ -z "$CONTENT" ]; then
  echo "Usage: ./poast.sh <content_json> [title]"
  exit 1
fi

# Build JSON payload
if [ -n "$TITLE" ]; then
  PAYLOAD=$(jq -n \
    --argjson content "$CONTENT" \
    --arg title "$TITLE" \
    '{content: $content, title: $title}')
else
  PAYLOAD=$(jq -n \
    --argjson content "$CONTENT" \
    '{content: $content}')
fi

curl -s -X POST "https://www.poast.bot/api/posts" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD"
