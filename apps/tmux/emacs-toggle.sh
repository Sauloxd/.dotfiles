#!/bin/sh
# F1 helper for tmux: toggle to/from the window named "emacs".
#
# First press jumps to the "emacs" window, remembering where we came from
# in the session option @emacs_back. Pressing F1 again while on the emacs
# window jumps back to that remembered window.
# If no window named "emacs" exists, do nothing.
#
# Args: $1 = session name, $2 = current window index (both passed by tmux).
sess="$1"
cur="$2"

# Find the index of the window named exactly "emacs" (first match).
tgt=$(tmux list-windows -t "$sess" -F '#{window_index} #{window_name}' \
  | awk '$2 == "emacs" { print $1; exit }')

# No emacs window -> nothing to do.
[ -n "$tgt" ] || exit 0

if [ "$cur" = "$tgt" ]; then
  # Already on emacs: go back to where we toggled from (fall back to last-window).
  back=$(tmux show-options -qv -t "$sess" @emacs_back)
  if [ -n "$back" ]; then
    tmux select-window -t "$sess:$back"
  else
    tmux last-window -t "$sess"
  fi
else
  # Jump to emacs, remembering the current window so we can come back.
  tmux set-option -t "$sess" @emacs_back "$cur" \; select-window -t "$sess:$tgt"
fi
