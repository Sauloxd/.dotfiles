#TODO: Load scripts so ZSH will override the alias

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
#
# ~/.oh-my-zsh/themes/
ZSH_THEME="spaceship"
#
# Command auto-correction.
ENABLE_CORRECTION="true"
#
# Red dot waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)
plugins+=(zsh-nvm)

# User configuration
#TODO: Whats going on...
source $ZSH/oh-my-zsh.sh > /dev/null
source ~/.bashrc

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
# if [ -f '/Users/saulofuruta/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/saulofuruta/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
# if [ -f '/Users/saulofuruta/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/saulofuruta/google-cloud-sdk/completion.zsh.inc'; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag --ignore db/migrate -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
