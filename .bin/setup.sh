#!/usr/bin/env bash

# Shamelessly stole from https://github.com/cowboy/dotfiles.
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[0;32m+\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m-\033[0m  $@"; }

if [[ ! "$SHELL" =~ zsh ]]; then
    e_error Current shell is not \`zsh\`. Please change your shell with \`chsh -s $(which zsh)\`
fi

dotfiles_path=$(cd "$(dirname $0)"/.. && pwd)

e_header "Setup script for my dotfiles: start"

# --- Git setup ---
e_header "Setting up git config"

git config --global user.name "Dmitry Kabanov"
git config --global user.email kabanovdmitry@gmail.com
git config --global color.ui auto
git config --global push.default simple

e_success "git config is successfull"

# --- Vim setup ---
e_header "Running vim setup"

mkdir $HOME/.vim/autoload
mkdir $HOME/.vim/plugged
mkdir $HOME/.vim/spell
mkdir $HOME/.vim/tmp

# Install vim plugin manager.
echo Installing vim plugin manager...
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mkdir -p ~/.local/share/nvim/site/autoload
cp ~/.vim/autoload/plug.vim ~/.local/share/nvim/site/autoload

# --- Tmux setup ---
e_header "Running tmux setup"

# Install tmux plugin manager.
if [[ `tmux -V` == *1.9* || `tmux -V` == *2.* ]]; then
    echo tmux version is fresh enough. Installing tmux plugin manager...
    if [ -d ~/.tmux/plugins/tpm ]; then
        rm -rf ~/.tmux/plugins/tpm
    fi
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo tmux version is outdated. Cannot install tmux plugin manager.
fi

e_header "Setup script for my dotfiles: finish"

unset e_header e_success e_error
unset dotfiles_path
