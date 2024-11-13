#!/usr/bin/env zsh

rsync \
    -avz --info=progress2 \
    --exclude="lost+found" \
    --exclude=".cache" \
    --exclude="pCloudDrive/" \
    --exclude="sw/" \
    --exclude="sciebo/" \
    --exclude="vscode-cpptools/" \
    --exclude="*.org~" \
    --exclude=".conda/" \
    --exclude=".cargo/" \
    --exclude=".julia/" \
    --exclude=".pcloud/" \
    --exclude="snap/" \
    --exclude=".vscode/" \
    --exclude=".vscode-server/" \
    --exclude=".emacs.d.doom/" \
    --exclude=".cursor/" \
    --exclude=".rustup/" \
    --exclude=".npm/" \
    --exclude=".texlive2021/" \
    --exclude=".zoom/" \
    --exclude=".vim/plugged/" \
    --delete \
    --delete-excluded \
    $HOME/ \
    $HOME/sciebo/backup/keldysh/home
