#!/usr/bin/env bash
# Daily To-Do Slack Notification
# Reads todos from todos.json and posts a formatted summary to Slack.
#
# Schedule: Mon-Fri + Sun at 9:00 AM PT
# Cron:     0 9 * * 0-5 TZ=America/Los_Angeles /path/to/notify.sh
#
# Setup: Set SLACK_WEBHOOK_URL in notifications/.env or as an environment variable.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV_FILE="$SCRIPT_DIR/.env"
TODOS_FILE="$SCRIPT_DIR/todos.json"

# Load webhook URL from .env if present
if [[ -f "$ENV_FILE" ]]; then
  source "$ENV_FILE"
fi

if [[ -z "${SLACK_WEBHOOK_URL:-}" ]]; then
  echo "Error: SLACK_WEBHOOK_URL is not set." >&2
  echo "Create $ENV_FILE with: SLACK_WEBHOOK_URL=https://hooks.slack.com/services/..." >&2
  exit 1
fi

if [[ ! -f "$TODOS_FILE" ]]; then
  echo "Error: $TODOS_FILE not found." >&2
  exit 1
fi

if ! command -v jq &>/dev/null; then
  echo "Error: jq is required. Install with: apt install jq / brew install jq" >&2
  exit 1
fi

TODAY="$(TZ=America/Los_Angeles date '+%a, %b %-d')"
COUNT="$(jq '.todos | length' "$TODOS_FILE")"

# Build the message
MESSAGE=":memo: *Justin's To-Do Summary — $TODAY*\n\n"

for i in $(seq 0 $((COUNT - 1))); do
  TASK="$(jq -r ".todos[$i].task" "$TODOS_FILE")"
  NUM_LINKS="$(jq ".todos[$i].links | length" "$TODOS_FILE")"

  # Build link text: (Link 1, Link 2, ...)
  LINK_PARTS=""
  for j in $(seq 0 $((NUM_LINKS - 1))); do
    URL="$(jq -r ".todos[$i].links[$j]" "$TODOS_FILE")"
    LINK_NUM=$((j + 1))
    if [[ -n "$LINK_PARTS" ]]; then
      LINK_PARTS="$LINK_PARTS, <$URL|Link $LINK_NUM>"
    else
      LINK_PARTS="<$URL|Link $LINK_NUM>"
    fi
  done

  IDX=$((i + 1))
  MESSAGE+="$IDX) $TASK ($LINK_PARTS)\n"
done

# Post to Slack
PAYLOAD="$(jq -n --arg text "$MESSAGE" '{text: $text, unfurl_links: false}')"

HTTP_CODE="$(curl -s -o /dev/null -w '%{http_code}' \
  -X POST -H 'Content-type: application/json' \
  --data "$PAYLOAD" \
  "$SLACK_WEBHOOK_URL")"

if [[ "$HTTP_CODE" == "200" ]]; then
  echo "Notification sent successfully."
else
  echo "Failed to send notification. HTTP $HTTP_CODE" >&2
  exit 1
fi
