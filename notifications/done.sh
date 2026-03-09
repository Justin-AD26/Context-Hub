#!/usr/bin/env bash
# Remove a completed task by its number.
#
# Usage: ./done.sh <task_number>
# Example: ./done.sh 4   (removes task #4, remaining tasks renumber automatically)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TODOS_FILE="$SCRIPT_DIR/todos.json"

if [[ -z "${1:-}" ]]; then
  echo "Usage: ./done.sh <task_number>"
  echo ""
  echo "Current tasks:"
  jq -r '.todos | to_entries[] | "  \(.key + 1)) \(.value.task)"' "$TODOS_FILE"
  exit 1
fi

TASK_NUM="$1"
COUNT="$(jq '.todos | length' "$TODOS_FILE")"

if [[ "$TASK_NUM" -lt 1 || "$TASK_NUM" -gt "$COUNT" ]]; then
  echo "Error: Task number must be between 1 and $COUNT." >&2
  exit 1
fi

INDEX=$((TASK_NUM - 1))
TASK_NAME="$(jq -r ".todos[$INDEX].task" "$TODOS_FILE")"

jq "del(.todos[$INDEX])" "$TODOS_FILE" > "$TODOS_FILE.tmp" && mv "$TODOS_FILE.tmp" "$TODOS_FILE"

echo "Removed: $TASK_NAME"
echo ""
echo "Remaining tasks:"
jq -r '.todos | to_entries[] | "  \(.key + 1)) \(.value.task)"' "$TODOS_FILE"
