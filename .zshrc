# vim:fdm=marker

# echo $PATH | tr ":" "\n"
# zmodload zsh/zprof

# Zplug {{{
source $HOME/.zplug/init.zsh

# Let zplug manage itself.
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# Completion settings.
zplug "lib/completion", from:oh-my-zsh

# Directory traversal options.
zplug "lib/directories", from:oh-my-zsh

# History options.
zplug "lib/history", from:oh-my-zsh

# Keybindings options.
zplug "lib/key-bindings", from:oh-my-zsh

# Add useful aliases and functions to work with git.
zplug "plugins/git", from:oh-my-zsh

# Autoload of the environment settings.
AUTOENV_FILE_ENTER=autoenv-enter.zsh
AUTOENV_FILE_LEAVE=autoenv-leave.zsh
zplug "Tarrasch/zsh-autoenv"

# Enable highlighing of commands whilst they are typed at a zsh prompt
# into an interactive terminal.
zplug "zsh-users/zsh-syntax-highlighting", defer:3

# Fish-like fast/unobtrusive autosuggestions for zsh.
# It suggests commands as you type based on history and completions.
zplug "zsh-users/zsh-autosuggestions"

zplug load
# }}}

# Environment variables {{{
if type nvim > /dev/null 2>&1; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi
#export BROWSER=google-chrome
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export dev=~/Sync/dev

export APPS_DIR=/sw
# }}}

# Aliases {{{

alias -g L="| less -R"
alias -g LL="2>&1 | less -R"
alias .....='cd ../../../..'
alias ....='cd ../../..'
alias ...='cd ../..'
alias ..='cd ..'
alias echoldlibrarypath='echo $LD_LIBRARY_PATH | tr : "\n"'
alias echomanpath='echo $MANPATH | tr : "\n"'
alias echopath='echo $PATH | tr : "\n"'
alias ls='ls -G'  # Colorize ls output
alias l='ls -lAhF'
alias notes='cd $HOME/Documents/Notes && vim'
alias posixtime='/usr/bin/time -p'
alias zshconfig="$EDITOR ~/.zshrc"
alias zshrestart="source ~/.zshrc"
if type nvim > /dev/null 2>&1; then
    alias v='nvim'
fi
alias dateiso8601='date "+%Y-%m-%d"'
alias dtiso8601='date "+%Y-%m-%d_%H.%M.%S"'  # e.g. 2024-01-02_14.16.27

if [[ "$(uname)" == "Darwin" ]]; then
    alias cp="cp -c"
fi

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
# Autocomplete filenames after = sign (e.g., in ./configure --prefix=PREFIX).
setopt magic_equal_subst
# }}}

# man customization {{{
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

# Dircolors for `ls` and `grep` {{{
if [ -x /usr/bin/dircolors -a -r $HOME/.dircolors ]; then
    eval "$(dircolors $HOME/.dircolors)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi
# }}}

# Starship prompt.
eval "$(starship init zsh)"

# Setup fuzzy search with FZF {{{
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type f --exclude pCloud\ Drive --exclude sw --hidden"
export FZF_CTRL_T_COMMAND="fd --type f --exclude pCloud\ Drive --exclude sw --hidden"
export FZF_ALT_C_COMMAND="fd --type d --exclude pCloud\ Drive --exclude sw --hidden"
# }}}

fpath=(~/.zsh $fpath)

# stt - set tab title
# Sets terminal tab title, particularly for Gnome Terminal that does not
# have GUI functionality for this.
function stt() {
    # Options for echo:
    # `-n` do not add a new line character in the end
    # `-e` interpret escape sequences (character sequences starting with \)
    echo -ne "\033]0;$*\007"
}

if [ -e "$HOME/.zshrc.local" ]; then
    . "$HOME/.zshrc.local"
fi
