#!/bin/sh -e

SCRIPT_DIR=$(dirname $0)

## スクリプトが dotfiles ディレクトリ直下にあると想定
DOTFILES_DIR=$SCRIPT_DIR

cd $DOTFILES_DIR
git submodule init
git submodule update
