#!/bin/bash

ln -sf ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/git/.gitignore_global ~/.gitignore_global
ln -sf ~/.dotfiles/git/.gitignore ~/.gitignore
ln -sf ~/.dotfiles/emacs/.ripgreprc ~/.ripgreprc

ZSH_VIM_DIR=~/.oh-my-zsh/custom/plugins/zsh-nvm
if [ ! -d $PUBLIC_LEGACY_DIR ]; then
  echo "--> Installing zsh-nvm plugin"
  git clone https://github.com/lukechilds/zsh-nvm $ZSH_VIM_DIR
fi

NVIM_DIR=~/.config/nvim
which nvim
HAS_NEOVIM=$?
if [[ HAS_NEOVIM -eq 0 ]]; then
  echo "--> nvim detected"
  mkdir -p ~/.config/nvim
  ln -sf ~/.dotfiles/vim/init.vim ~/.config/nvim/init.vim
fi

echo "--> Installing plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
