#!/bin/bash
#
#Inspired by https://github.com/mathiasbynens/dotfiles
#Sourcing files, ORDER matters.

source ~/development/revmob/setup/.bash_profile

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

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

