export ZSH=$HOME/.oh-my-zsh

# ZSH customization
ZSH_THEME="spaceship"
COMPLETION_WAITING_DOTS="true"
plugins=(git)
plugins+=(zsh-nvm)

# User configuration
source $ZSH/oh-my-zsh.sh > /dev/null
source ~/.bashrc

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag --ignore db/migrate -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
