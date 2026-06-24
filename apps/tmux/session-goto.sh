#!/bin/sh
# Switch to the Nth session in the SAME order as the top session-tab bar.
#
# The bar order is the CUSTOM @sess_order (space-separated session ids) kept by
# session-move.sh (< / >) and session-bar-build.sh, so we read that here too.
# This keeps "leader s <N>" aligned with the visible tab positions even after
# sessions have been reordered.
#
# Arg: $1 = 1-based index (1 = first tab in the bar). No-op if out of range.
n="$1"
here=$(dirname "$0")

order=$(tmux show -gv @sess_order 2>/dev/null)
if [ -z "$order" ]; then
  sh "$here/session-bar-build.sh"
  order=$(tmux show -gv @sess_order 2>/dev/null)
fi

target=$(printf '%s' "$order" | cut -d' ' -f"$n")
[ -n "$target" ] && tmux switch-client -t "$target"
