#!/bin/sh
# Build the top session-tab strip (powerline) honoring a CUSTOM order stored in
# the @sess_order option (space-separated session ids; ids never contain spaces).
#
# tmux can't reorder sessions natively, so we keep our own order: reconcile it
# against the live session list (drop dead ids, append new ones in creation
# order), then generate pane-border-format as one conditional segment per
# session. Each segment highlights live & per-client via #{client_session}, so
# switching sessions needs no rebuild — only add/remove/rename/reorder do.

MANTLE=#181825; S0=#313244; OV1=#7f849c; MAUVE=#cba6f7; CRUST=#11111b
GL=$(printf '\356\202\262')   # U+E0B2  (left cap)
GR=$(printf '\356\202\260')   # U+E0B0  (right cap)

ids=$(tmux list-sessions -F '#{session_id}')
order=$(tmux show -gv @sess_order 2>/dev/null)

# Reconcile: keep stored ids that still exist (in stored order)...
neworder=""
for id in $order; do
  printf '%s\n' "$ids" | grep -qxF "$id" && neworder="$neworder $id"
done
# ...then append any new sessions (creation order) not already listed.
for id in $(printf '%s\n' "$ids" | sort -t '$' -k2 -n); do
  printf '%s\n' "$neworder" | tr ' ' '\n' | grep -qxF "$id" || neworder="$neworder $id"
done
neworder=$(printf '%s' "$neworder" | sed 's/^ *//')
tmux set -g @sess_order "$neworder"

# Build the strip: one #{?...} segment per session, in order.
strip="#[align=left]#[bg=$MANTLE]"
for id in $neworder; do
  name=$(tmux display-message -p -t "$id" '#{session_name}')
  inact="#[fg=$S0]#[bg=$MANTLE]$GL#[fg=$OV1]#[bg=$S0] $name #[fg=$S0]#[bg=$MANTLE]$GR "
  act="#[fg=$MAUVE]#[bg=$MANTLE]$GL#[fg=$CRUST]#[bg=$MAUVE]#[bold] $name #[fg=$MAUVE]#[bg=$MANTLE]#[nobold]$GR "
  strip="$strip#{?#{==:#{client_session},$name},$act,$inact}"
done

# Only draw on top-edge panes (pane_top == 1 once the border row is counted).
tmux set -g pane-border-format "#{?#{e|==:#{pane_top},1},$strip,}"
