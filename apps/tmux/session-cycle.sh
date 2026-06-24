#!/bin/sh
# Cycle to the next/previous session in the SAME order as the top session-tab
# bar, wrapping around the ends.
#
# The bar order is the CUSTOM @sess_order (space-separated session ids) that
# session-move.sh (< / >) and session-bar-build.sh maintain. We read that same
# option here so cycling always tracks the visible bar, even after sessions have
# been reordered. (tmux session ids are immutable, so we cannot sort by them and
# expect to match a user-reordered bar.)
#
# Arg: $1 = next | prev
dir="$1"
here=$(dirname "$0")

order=$(tmux show -gv @sess_order 2>/dev/null)
# First use (or stale): reconcile @sess_order against the live session list.
if [ -z "$order" ]; then
  sh "$here/session-bar-build.sh"
  order=$(tmux show -gv @sess_order 2>/dev/null)
fi

cur=$(tmux display-message -p '#{session_id}')
count=$(printf '%s' "$order" | wc -w | tr -d ' ')
[ "$count" -gt 0 ] || exit 0

# Current 1-based index within @sess_order.
idx=0; i=1
for id in $order; do [ "$id" = "$cur" ] && idx=$i; i=$((i + 1)); done
[ "$idx" -eq 0 ] && exit 0

if [ "$dir" = prev ]; then
  n=$((idx - 1)); [ "$n" -lt 1 ] && n="$count"
else
  n=$((idx + 1)); [ "$n" -gt "$count" ] && n=1
fi

target=$(printf '%s' "$order" | cut -d' ' -f"$n")
[ -n "$target" ] && tmux switch-client -t "$target"
