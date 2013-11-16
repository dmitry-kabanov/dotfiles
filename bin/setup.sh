# Shamelessly stole from https://github.com/cowboy/dotfiles.
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[0;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }

e_header "Setting up git config"
git config --global user.name "Dmitry Kabanov"
git config --global user.email kabanovdmitry@gmail.com
git config --global color.ui auto
git config --global push.default simple
e_success "git config is successfull"

e_header "Linking files into home directory"
DIR=$( dirname "${BASH_SOURCE[0]}" )
cd $DIR
DIR2=$(pwd)
DIR3=$(dirname $DIR2)

dotfiles="vimrc tmux.conf zsh-customization cgdbrc"
for dotfile in $dotfiles; do
    if [ -f $HOME/.$dotfile ]; then
        e_error "$dotfile exists in the home directory already."
    else
        ln -s $DIR3/$dotfile $HOME/.$dotfile
        e_success "Linked successfully: $dotfile"
    fi
done

# Create tmp directory for Vim backup files.
mkdir -p ~/.vim/tmp

# Instal vim-pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle;
curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# Install vim-fugitive
cd ~/.vim/bundle
git clone git://github.com/tpope/vim-fugitive.git

# Install vim-solarized
cd ~/.vim/bundle
git clone git://github.com/altercation/vim-colors-solarized.git

# Install vim-capslock
cd ~/.vim/bundle
git clone git://github.com/tpope/vim-capslock.git
