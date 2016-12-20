# vim:fdm=marker

# Load Lmod environment modules tool.
if [ -f $HOME/apps/lmod/lmod/init/profile ]; then
   source $HOME/apps/lmod/lmod/init/profile
fi

# Load plugins with zplug {{{
source $HOME/.zplug/init.zsh

# Add useful aliases and functions to work with git.
zplug "plugins/git", from:oh-my-zsh

# Theme `blinks` works if $SOLARIZED_THEME is either `dark` or `light`.
if [ $(hostname) = 'dima-macbook-air.local' ]; then
    export SOLARIZED_THEME=dark
else
    export SOLARIZED_THEME=light
fi
zplug "themes/blinks", from:oh-my-zsh, as:theme

# Autoload of the environment settings.
AUTOENV_FILE_ENTER=autoenv-enter.zsh
AUTOENV_FILE_LEAVE=autoenv-leave.zsh
zplug "Tarrasch/zsh-autoenv"

# Completion settings.
zplug "lib/completion", from:oh-my-zsh

# History options.
zplug "lib/history", from:oh-my-zsh

# Directory traversal options.
zplug "lib/directories", from:oh-my-zsh

# Keybindings options.
zplug "lib/key-bindings", from:oh-my-zsh

# Enable highlighing of commands whilst they are typed at a zsh prompt
# into an interactive terminal.
zplug "zsh-users/zsh-syntax-highlighting", defer:3

zplug load
# }}}


# ###################
# My custom settings.

# eval `dircolors $HOME/.dir_colors/dircolors`

# Set environment variables.
export dev=~/Dropbox/dev
export EDITOR=vim
export BROWSER=google-chrome
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Aliases {{{

alias -g C="| wc -l"
alias -g L="| less"
alias -g LL="2>&1 | less"
alias .....='cd ../../../..'
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias echoldlibrarypath='echo $LD_LIBRARY_PATH | tr : "\n"'
alias echomanpath='echo $MANPATH | tr : "\n"'
alias echopath='echo $PATH | tr : "\n"'
alias l='ls -lAhF'
alias notes='cd $HOME/Documents/Notes && vim'
alias posixtime='/usr/bin/time -p'
alias zshconfig="$EDITOR ~/.zshrc"
alias zshrestart="source ~/.zshrc"
alias .f='cd $dev/github/_dotfiles'

# Tmux aliases.
alias tmat='tmux attach -t'
alias tmad='tmux attach -d -t'
alias tmns='tmux new-session -s'
alias tmls='tmux list-sessions'
alias tmks='tmux kill-session -t'
# }}}

# ZSH options {{{
# AUTOCD option lets you type the name of a directory to change into into it.
setopt autocd
setopt extendedglob
# }}}

# man customization {{{
alias zshconfig="vim ~/.zsh-customization"
alias zshrestart="source ~/.zshrc"
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias timepython='/usr/bin/time -p python'
alias posixtime='/usr/bin/time -p'

# Set environment variables.
export dev=~/Dropbox/dev
export notes=~/Documents/Notes
export EDITOR=vim
export BROWSER=google-chrome
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ZSH options.
setopt extendedglob

man() {
    # Attributes are set using escape sequences starting with `\e[`.
    # Attributes codes can be found here:
    # http://www.termsys.demon.co.uk/vtansi.htm
    local mb=$(printf "\e[1;31m")   # Begin blinking.
    local md=$(printf "\e[1;31m")   # Begin bold.
    local me=$(printf "\e[0m")      # End mode.
    local so=$(printf "\e[7m")      # Begin standout mode.
    local se=$(printf "\e[0m")      # End standout mode.
    local us=$(printf "\e[4;32m")   # Begin underline.
    local ue=$(printf "\e[0m")      # End underline.
    env LESS_TERMCAP_mb=$mb \
        LESS_TERMCAP_md=$md \
        LESS_TERMCAP_me=$me \
        LESS_TERMCAP_so=$so \
        LESS_TERMCAP_se=$se \
        LESS_TERMCAP_us=$us \
        LESS_TERMCAP_ue=$ue \
        MANWIDTH=80 \
        man "$@"
}
# }}}

# EasyBuild options {{{
export EASYBUILD_BUILDPATH=/tmp/$USER/easybuild/buildpath
export EASYBUILD_INSTALLPATH=$HOME/apps/easybuild
export EASYBUILD_MODULES_TOOL=Lmod
export EASYBUILD_SUBDIR_MODULES=modulefiles
export EASYBUILD_SUBDIR_SOFTWARE=software
# }}}

if [ -e ${HOME}/.zshrc-local ]; then
    . ${HOME}/.zshrc-local
fi
