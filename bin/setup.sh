# Shamelessly stole from https://github.com/cowboy/dotfiles.
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[0;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }

e_header "Setting up git config"
git config --global user.name "Dmitry Kabanov"
git config --global user.email kabanovdmitry@gmail.com
e_success "git config is successfull"

e_header "Linking files into home directory"
DIR=$( dirname "${BASH_SOURCE[0]}" )
cd $DIR
DIR2=$(pwd)
DIR3=$(dirname $DIR2)

dotfiles="vimrc tmux.conf zsh-customization"
for dotfile in $dotfiles; do
    if [ -f $HOME/.$dotfile ]; then
        e_error "$dotfile exists in the home directory already."
    else
        ln -s $DIR3/$dotfile $HOME/.$dotfile
        e_success "Linked successfully: $dotfile"
    fi
done
