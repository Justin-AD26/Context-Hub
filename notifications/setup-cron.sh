#!/usr/bin/env bash
# Installs the cron job for daily to-do notifications.
# Schedule: Mon-Fri (1-5) + Sun (0) at 9:00 AM PT
#
# Usage: ./setup-cron.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NOTIFY_SCRIPT="$SCRIPT_DIR/notify.sh"

if [[ ! -x "$NOTIFY_SCRIPT" ]]; then
  echo "Error: $NOTIFY_SCRIPT not found or not executable." >&2
  exit 1
fi

# Cron expression: 9:00 AM, Sun(0) + Mon-Fri(1-5) = 0-5
CRON_ENTRY="0 9 * * 0-5 TZ=America/Los_Angeles $NOTIFY_SCRIPT"

# Check if already installed
if crontab -l 2>/dev/null | grep -qF "$NOTIFY_SCRIPT"; then
  echo "Cron job already installed. Current entry:"
  crontab -l | grep -F "$NOTIFY_SCRIPT"
  exit 0
fi

# Append to existing crontab
(crontab -l 2>/dev/null; echo "$CRON_ENTRY") | crontab -

echo "Cron job installed:"
echo "  $CRON_ENTRY"
echo ""
echo "Verify with: crontab -l"
echo "Test now with: $NOTIFY_SCRIPT"
