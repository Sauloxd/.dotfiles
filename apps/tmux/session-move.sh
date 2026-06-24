#!/bin/sh
# Move the current session left or right in the custom @sess_order, then rebuild
# the top bar. Arg: $1 = left | right.
dir="$1"
here=$(dirname "$0")

# Reconcile order first (also picks up any new/removed sessions).
sh "$here/session-bar-build.sh"

order=$(tmux show -gv @sess_order)
cur=$(tmux display-message -p '#{session_id}')
n=$(printf '%s' "$order" | wc -w | tr -d ' ')

# Current index (1-based) in the order.
idx=0; i=1
for id in $order; do [ "$id" = "$cur" ] && idx=$i; i=$((i + 1)); done
[ "$idx" -eq 0 ] && exit 0

if [ "$dir" = left ]; then j=$((idx - 1)); else j=$((idx + 1)); fi
[ "$j" -lt 1 ] && exit 0          # already at the left edge
[ "$j" -gt "$n" ] && exit 0       # already at the right edge

# Rebuild the list with positions idx and j swapped.
out=""; i=1
for id in $order; do
  if [ "$i" -eq "$idx" ]; then
    out="$out $(printf '%s' "$order" | cut -d' ' -f"$j")"
  elif [ "$i" -eq "$j" ]; then
    out="$out $cur"
  else
    out="$out $id"
  fi
  i=$((i + 1))
done

tmux set -g @sess_order "$(printf '%s' "$out" | sed 's/^ *//')"
sh "$here/session-bar-build.sh"
