#!/bin/bash
# Delete a post
# Usage: ./poast_delete.sh <post_id>
#
# Example:
#   ./poast_delete.sh "post-uuid-here"

set -e

# Load auth helper
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/_auth.sh"
require_token

POST_ID="$1"

if [ -z "$POST_ID" ]; then
  echo "Usage: ./poast_delete.sh <post_id>"
  exit 1
fi

curl -s -X DELETE "https://www.poast.sh/api/posts/$POST_ID" \
  -H "Authorization: Bearer $TOKEN"
