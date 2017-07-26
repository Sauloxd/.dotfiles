#TODO: Load scripts so ZSH will override the alias

# Path to your oh-my-zsh installation.
export ZSH=/Users/sauloxd/.oh-my-zsh
#
# ~/.oh-my-zsh/themes/
ZSH_THEME="spaceship"
#
# Command auto-correction.
ENABLE_CORRECTION="true"
#
# Red dot waiting for completion
COMPLETION_WAITING_DOTS="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration
#TODO: Whats going on...
source $ZSH/oh-my-zsh.sh > /dev/null
source ~/.bashrc

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
