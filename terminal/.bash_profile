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

