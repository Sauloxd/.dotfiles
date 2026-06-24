#!/bin/sh
# Option+Tab helper for tmux: cycle to the next window, ALWAYS skipping any
# window named "emacs" (F1 is the dedicated toggle for emacs).
#
# We step forward with next-window and stop on the first non-emacs window.
# The loop is bounded by the window count so it can't spin forever if every
# window happens to be named "emacs".
#
# Args: $1 = session name (passed by tmux).
sess="$1"

count=$(tmux display-message -p -t "$sess" '#{session_windows}')
i=0
while [ "$i" -lt "$count" ]; do
  tmux next-window -t "$sess"
  i=$((i + 1))
  name=$(tmux display-message -p -t "$sess" '#{window_name}')
  [ "$name" = "emacs" ] || break
done
