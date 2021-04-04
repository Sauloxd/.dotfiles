#!/bin/bash

# Var needed for git to work https://gist.github.com/madeagency/79dc86e8aa09aa512af5
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# # Required to ssh to machines
# eval "$(ssh-agent -s)" > /dev/null

# C-e open command + vim
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Use fd instead o find
