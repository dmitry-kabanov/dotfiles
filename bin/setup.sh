# Shamelessly stole from https://github.com/cowboy/dotfiles.
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[0;32m+\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m-\033[0m  $@"; }

DIR=$( dirname "${BASH_SOURCE[0]}" )
cd $DIR
DIR2=$(pwd)
DIR3=$(dirname $DIR2)

e_header "Setting up git config"
git config --global user.name "Dmitry Kabanov"
git config --global user.email kabanovdmitry@gmail.com
git config --global color.ui auto
git config --global push.default simple
e_success "git config is successfull"

e_header "Linking files into home directory"

declare -a dotfiles=(tmux.conf cgdbrc aspell.en.pws aspell.en.prepl Xresources)

for dotfile in ${dotfiles[@]}; do
    if [ -L $HOME/.$dotfile ]; then
        rm $HOME/.$dotfile
    fi
    if [ -f $HOME/.$dotfile ]; then
        e_error "Moving $HOME/.$dotfile to $HOME/.$dotfile.bak."
    fi
    ln -s $DIR3/$dotfile $HOME/.$dotfile
    e_success "Linked successfully: $dotfile"
done

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
ln -s $DIR3/vim/after $HOME/.vim/after
ln -s $DIR3/vim/autoload $HOME/.vim/autoload
ln -s $DIR3/vim/vimrc $HOME/.vim/init.vim
ln -s $DIR3/vim/keymap $HOME/.vim/keymap
mkdir $HOME/.vim/plugged
mkdir $HOME/.vim/spell
mkdir $HOME/.vim/tmp
ln -s $DIR3/vim/UltiSnips $HOME/.vim/UltiSnips
ln -s $DIR3/vim/vimrc $HOME/.vim/vimrc

# Linking ~/.tmux directory.
if [ -L ~/.tmux ]; then
    rm ~/.tmux
fi
if [ -d "~/.tmux" ];
then
    echo Moving ~/.tmux to ~/.tmux.bak
    mv ~/.tmux ~/.tmux.bak
fi
ln -s $DIR3/tmux $HOME/.tmux

# Install vim plugin manager.
echo Installing vim plugin manager...
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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
