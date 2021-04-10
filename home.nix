{ pkgs, ... }:

# A Good reference
# https://github.com/datakurre/nix-files/blob/master/home-configuration.nix
# 
{
  home = {
    packages = with pkgs; [
      autojump
      vim
      htop
      git
      iosevka
      ripgrep
      neovim
      deno
      fd
    ];
    file = {
    # See options here: https://github.com/nix-community/home-manager/blob/master/modules/files.nix
      ".bashrc" = {
        source = "/Users/saulofuruta/.dotfiles/terminal/bashrc";
        force = true;
      };
      ".bash_profile" = {
        source = "/Users/saulofuruta/.dotfiles/terminal/bash_profile";
        force = true;
      };
      ".gitignore" = {
        source = "/Users/saulofuruta/.dotfiles/git/.gitignore";
        force = true;
      };
      ".ssh/config".force = true;
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

    zsh = {
      enable = true;
      enableCompletion = false;
      enableAutosuggestions = true;
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
      };
      initExtra = ''
        ZSH_DISABLE_COMPFIX=true
        ZDOTDIR=$ZSH #zcompdump, for speed up init https://stackoverflow.com/questions/47745184/change-location-of-zcompdump-files
        source $HOME/.dotfiles/terminal/p10k.zsh
        source $HOME/.bashrc
        eval "$(fnm env)"
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
    
  }

}
