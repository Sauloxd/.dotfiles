#!/bin/bash
#
#Inspired by https://github.com/mathiasbynens/dotfiles
#Sourcing files, ORDER matters.

for file in $HOME/.dotfiles/terminal/.{variables,path,exports,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

for file in $HOME/.dotfiles/aliases/.aliases; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

#REFACTOR this
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
