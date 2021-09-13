#!/bin/bash

# 1. Check for xcode install
xcode-select --install

# 2. Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Install Nix
# If you already have /nix mounted, rermove it i diskutil and try again
# @TODO: automate this step
curl -L https://nixos.org/nix/install | sh -s -- --darwin-use-unencrypted-nix-store-volume

# 4. Install home-manager
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
nix-shell '<home-manager>' -A install

# 5. Clone dotfiles
git clone https://github.com/Sauloxd/.dotfiles.git

# 6. Link home.nix
ln -sf ~/dotfiles/macos/home.nix ~/.config/nixpkgs/home.nix

# 7. Run home-manager
home-manager switch

# 8. Brew install
brew install

# 9. Install
curl -sLf https://spacevim.org/install.sh | bash
