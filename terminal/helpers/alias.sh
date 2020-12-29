#!/bin/bash

alias vv="nvim ~/.config/nvim/init.vim"
alias aa="nvim ~/.dotfiles/aliases/.aliases"
alias ss="source ~/.dotfiles/terminal/.bash_profile"
alias v="nvim"
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias h='history'
alias gblst="git for-each-ref --sort=-committerdate --count=10 --format='%(refname:short)' refs/heads/"
alias gh="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias ggpnv='git push --set-upstream origin $(git branch --show-current) --no-verify'

# doom
alias doom-refresh="~/.emacs.d/bin/doom refresh"
alias top="vtop --theme=wizard"

alias yrn="yarn"
alias yran="yarn"
alias yanr="yarn"
alias tx="tmuxinator"
alias kqr="tmux kill-session -t qr"
alias qr="tx start qr"

alias ee="nvim ~/dev/github/eslint-config-sxd/index.js"
