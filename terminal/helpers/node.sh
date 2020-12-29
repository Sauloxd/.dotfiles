#!/bin/bash

# Fast node manager is a fast replacement for nvm
# https://hackernoon.com/fnm-fast-and-simple-node-js-version-manager-df82c37d4e87

export PATH=$HOME/.fnm:$PATH

eval "`fnm env`"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
