#!/usr/bin/env zsh

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

# --- Linking misc files ---
e_header "Linking files into HOME directory"

declare -a dotfiles=(cgdbrc aspell.en.pws aspell.en.prepl Xresources)

for dotfile in ${dotfiles[@]}; do
    if [ -L $HOME/.$dotfile ]; then
        rm $HOME/.$dotfile
    fi
    if [ -f $HOME/.$dotfile ]; then
        e_error "Moving $HOME/.$dotfile to $HOME/.$dotfile.bak."
    fi
    ln -s $dotfiles_path/$dotfile $HOME/.$dotfile
    e_success "Linked successfully: $dotfile"
done

# --- Vim setup ---
e_header "Running vim setup"

# Linking ~/.vim directory.
if [ -L ~/.vim ]; then
    rm ~/.vim
fi
if [ -d "~/.vim" ];
then
    echo Moving ~/.vim to ~/.vim.bak
    mv ~/.vim ~/.vim.bak
fi

mkdir $HOME/.vim
ln -s $dotfiles_path/vim/after $HOME/.vim/after
ln -s $dotfiles_path/vim/autoload $HOME/.vim/autoload
ln -s $dotfiles_path/vim/init.vim $HOME/.vim/init.vim
ln -s $dotfiles_path/vim/keymap $HOME/.vim/keymap
mkdir $HOME/.vim/plugged
mkdir $HOME/.vim/spell
mkdir $HOME/.vim/tmp
ln -s $dotfiles_path/vim/UltiSnips $HOME/.vim/UltiSnips

# Install vim plugin manager.
echo Installing vim plugin manager...
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# --- Tmux setup ---
e_header "Running tmux setup"

# Linking ~/.tmux directory.
if [ -L ~/.tmux ]; then
    rm ~/.tmux
fi
if [ -d "~/.tmux" ];
then
    echo Moving ~/.tmux to ~/.tmux.bak
    mv ~/.tmux ~/.tmux.bak
fi
ln -s $dotfiles_path/tmux $HOME/.tmux
ln -s $dotfiles_path/tmux.conf $HOME/.tmux.conf

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
