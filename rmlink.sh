#!/bin/sh -e

SCRIPT_DIR=$(dirname $0)

## スクリプトが dotfiles ディレクトリ直下にあると想定
DOTFILES_DIR=$SCRIPT_DIR

function usage() {
    echo "Usage: $0" 1>&2
    exit 1
}
function error() {
    echo "Error: $0 $1" 1>&2
    exit 1
}

## 実行はホームディレクトリでなければならない
if [ "$HOME" != "$(pwd)" ]; then
    error "exec $0 at your home directory: $HOME";
fi

NOW=$(date +%Y%m%d%H%M%S)

function rmlink() {
    NAME=$1
    BACKUP=${NAME}.${NOW}
    if [ -e "$NAME" ]; then
        echo "rm $NAME (mv $NAME $BACKUP)"
        mv $NAME $BACKUP
    fi
}

## .git* 以外の dotfiles リンクを削除
for F in $(find $DOTFILES_DIR -name '.*' -maxdepth 1 | grep -v '\.git');
do
    NAME=$(basename $F)
    rmlink $NAME
done

## .git* をリンクを削除
for NAME in .gitconfig;
do
    ## dotfiles で管理されているものだけ削除
    DOTFILE=${DOTFILES_DIR}/${NAME}
    if [ -e "$DOTFILE" ]; then
        rmlink $NAME
    fi
done
