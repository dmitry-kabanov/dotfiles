#!/usr/bin/env zsh

rsync \
    -avz --info=progress2 \
    --exclude="*.org~" \
    --exclude=".cache" \
    --exclude=".cargo/" \
    --exclude=".conda/" \
    --exclude=".config/Code/"\
    --exclude=".config/Code - Insiders/"\
    --exclude=".config/Cursor/" \
    --exclude=".cursor/" \
    --exclude=".emacs.d.doom.bak/" \
    --exclude=".emacs.d.doom/" \
    --exclude=".emacs.d.vanilla/" \
    --exclude=".julia/" \
    --exclude=".local/share/Trash" \
    --exclude=".local/share/Zeal" \
    --exclude=".local/share/gnome-boxes/images/" \
    --exclude=".npm/" \
    --exclude=".pcloud" \
    --exclude=".rustup/" \
    --exclude=".texlive2021/" \
    --exclude=".vim/plugged/" \
    --exclude=".vscode-server/" \
    --exclude=".vscode/" \
    --exclude=".vscode-insiders/" \
    --exclude=".zoom/" \
    --exclude="MaRDICloud" \
    --exclude="Sciebo/" \
    --exclude="dev" \
    --exclude="lost+found" \
    --exclude="pCloudDrive/" \
    --exclude="snap/" \
    --exclude="sw" \
    --exclude="vscode-cpptools/" \
    --delete \
    --delete-excluded \
    $HOME/ \
    $HOME/Sciebo/backup/keldysh/home
