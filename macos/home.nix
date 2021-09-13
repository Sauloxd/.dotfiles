{ pkgs, ... }:

# A Good reference
# https://github.com/datakurre/nix-files/blob/master/home-configuration.nix
#
# Install using home-manager
# `home-manager switch`
let
  DOTFILES = "/Users/sauloxd/.dotfiles";
in
{
  home = {
    packages = with pkgs; [
      zsh
      fzf
      vim
      htop
      git
      ripgrep
      neovim
      fd
      emacs
      tmux
    ];
    file = {
      ".hushlogin" = {
        text = "";
        force = true;
      };
      ".gitignore_global" = {
        source = "${DOTFILES}/apps/git/gitignore";
        force = true;
      };
      "Brewfile" = {
        source = "${DOTFILES}/macos/Brewfile";
        force = true;
      };
      ".ssh/config".force = true;

      #tmux
      ".tmux.conf.local" = {
        source = "${DOTFILES}/apps/tmux/tmux.conf.local";
      };
      ".tmux.conf" = {
        source = "${DOTFILES}/apps/tmux/tmux.conf/.tmux.conf";
      };
      # Emacs
      ".doom.d/+my-org.el" = {
        source = "${DOTFILES}/apps/emacs/+my-org.el";
        force = true;
      };
      ".doom.d/config.el" = {
        source = "${DOTFILES}/apps/emacs/config.el";
        force = true;
      };
      ".doom.d/init.el" = {
        source = "${DOTFILES}/apps/emacs/init.el";
        force = true;
      };
      ".doom.d/packages.el" = {
        source = "${DOTFILES}/apps/emacs/packages.el";
        force = true;
      };
    };
  };

  programs = {
    autojump = {
      enable = true;
      enableFishIntegration = true;
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    bash = {
      shellAliases = {
        vv = "nvim ~/.config/nvim/init.vim";
        aa = "nvim ~/.dotfiles/aliases/.aliases";
        ss = "source ~/.dotfiles/terminal/.bash_profile";
        v = "nvim";
        grep = "grep --color";
        sgrep = "grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} ";
        h = "history";
        gblst = "git for-each-ref --sort=-committerdate --count=10 --format='%(refname:short)' refs/heads/";
        gh = "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
        ggpnv = "git push --set-upstream origin $(git branch --show-current) --no-verify";
        doom-refresh = "~/.emacs.d/bin/doom refresh";
        top = "vtop --theme=wizard";
        yrn = "yarn";
        yran = "yarn";
        yanr = "yarn";
        tx = "tmuxinator";
        kqr = "tmux kill-session -t qr";
        qr = "tx start qr";
      };
    };

    git = {
      enable = true;
      userEmail = "saulotoshi@gmail.com";
      userName = "sauloxd";
      ignores = [".DS_Store"];
    };

    zsh = {
      enable = true;
      enableCompletion = false;
      enableAutosuggestions = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
	      theme = "robbyrussell";
      };
      initExtra = ''
        export EDITOR="nvim"

        if [ -e /Users/sauloxd/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/sauloxd/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

        # https://hackernoon.com/fnm-fast-and-simple-node-js-version-manager-df82c37d4e87
        export PATH=$HOME/.fnm:$PATH

        export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

        export PATH="$PATH:$HOME/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

        export PATH="/usr/local/sbin:/usr/local/bin/:$PATH"

        export PATH=$PATH:"/Applications/Postgres.app/Contents/Versions/latest/bin";

        export PATH=$PATH:"/Applications/Sublime Text.app/Contents/SharedSupport/bin";

        export PATH=$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin";

        export PATH="$PATH:$HOME/.emacs.d/bin"

        export PATH="$PATH:/usr/local/opt/libpq/bin"

        export PATH="/usr/local/opt/sqlite/bin:$PATH"

        export PATH="$PATH:$HOME/.rvm/bin"

        # Var needed for git to work https://gist.github.com/madeagency/79dc86e8aa09aa512af5
        export LC_CTYPE=en_US.UTF-8
        export LC_ALL=en_US.UTF-8

        ZSH_DISABLE_COMPFIX=true
        ZDOTDIR=$ZSH #zcompdump, for speed up init https://stackoverflow.com/questions/47745184/change-location-of-zcompdump-files

        eval "$(fnm env)"

        # C-e open command + vim
        autoload edit-command-line; zle -N edit-command-line
        bindkey '^e' edit-command-line

        # VSCODE apple config
        defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
        defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
        # # If necessary, reset global default
        # defaults delete -g ApplePressAndHoldEnabled
      '';
    };

    ssh = {
      enable = true;
      extraConfig = ''
        Host *
          IgnoreUnknown AddKeysToAgent,UseKeychain
          AddKeysToAgent yes
          UseKeychain yes
          IdentityFile ~/.ssh/id_ed25519
      '';
    };

    home-manager = {
      enable = true;
    };
  };
}
