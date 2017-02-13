# Path to your oh-my-zsh installation.
export ZSH=/Users/sauloxd/.oh-my-zsh
#
# ~/.oh-my-zsh/themes/
ZSH_THEME="robbyrussell"
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
source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Case-insensitive globbing (used in pathname expansion)
setopt -s nocaseglob;

# Autocorrect typos in path names when using `cd`
setopt -s cdspell;

