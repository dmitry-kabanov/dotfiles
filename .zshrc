# vim:fdm=marker

zmodload zsh/zprof

# Spack and Lmod {{{
# if [ -f $HOME/sw/spack/share/spack/setup-env.sh ]; then
#     # Get lmod path with `$(spack location -i lmod)`.
#     lmod_path="$HOME/sw/spack/opt/spack/darwin-mojave-x86_64/clang-10.0.1-apple/lmod-7.8.15-oq3ljl2vcih7w5y4piibmgi2zsxs3n3h"
#     export MODULEPATH="$HOME/sw/modulefiles/Core:$MODULEPATH"
#     source $HOME/sw/spack/share/spack/setup-env.sh
#     source ${lmod_path}/lmod/lmod/init/zsh
#     source $HOME/sw/spack/share/spack/setup-env.sh
# fi
# }}}

# Conda {{{
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dima/sw/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dima/sw/conda/etc/profile.d/conda.sh" ]; then
        . "/Users/dima/sw/conda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dima/sw/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
# }}}

# Zplug {{{
# source $HOME/.zplug/init.zsh
# 
# # Let zplug manage itself.
# zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# 
# # Completion settings.
# zplug "lib/completion", from:oh-my-zsh
# 
# # Directory traversal options.
# zplug "lib/directories", from:oh-my-zsh
# 
# # History options.
# zplug "lib/history", from:oh-my-zsh
# 
# # Keybindings options.
# zplug "lib/key-bindings", from:oh-my-zsh
# 
# # Add useful aliases and functions to work with git.
# zplug "plugins/git", from:oh-my-zsh
# 
# # Theme `blinks` works if $SOLARIZED_THEME is either `dark` or `light`.
# if [ -z $SOLARIZED_THEME ]; then
#     if [ "$(hostname)" = 'dima-macbook-air.local' -o -n "$SSH_CONNECTION" ]; then
#         export SOLARIZED_THEME=dark
#     else
#         export SOLARIZED_THEME=light
#     fi
# fi
# # zplug "~/.zsh/", from:local, as:theme
# 
# # Autoload of the environment settings.
# AUTOENV_FILE_ENTER=autoenv-enter.zsh
# AUTOENV_FILE_LEAVE=autoenv-leave.zsh
# zplug "Tarrasch/zsh-autoenv"
# 
# # Enable highlighing of commands whilst they are typed at a zsh prompt
# # into an interactive terminal.
# zplug "zsh-users/zsh-syntax-highlighting", defer:3
# 
# zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
# 
# zplug load
# }}}

# Environment variables {{{
if type nvim > /dev/null 2>&1; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi
export BROWSER=google-chrome
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export dev=~/Sync/dev

export APPS_DIR=/sw
# }}}

# Aliases {{{

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
if type nvim > /dev/null 2>&1; then
    alias vim='nvim'
    alias v='nvim'
fi
alias dateiso8601='date "+%Y-%m-%d"'

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

if [ -e $HOME/.zshrc-local ]; then
    . $HOME/.zshrc-local
fi

# Setup Rust programming language environment.
[ -f ~/.cargo/env ] && source ~/.cargo/env

#. ~/.zplug/repos/Tarrasch/zsh-autoenv/init.zsh

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
      zdharma/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions \
  blockf atpull'zinit creinstall -q .' \
      zsh-users/zsh-completions

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-bin-gem-node

# Completion.
zinit snippet "OMZ::lib/completion.zsh"
# Directory traversal options.
zinit snippet "OMZ::lib/directories.zsh"
# History options.
zinit snippet "OMZ::lib/history.zsh"
# Keybindings options.
zinit snippet "OMZ::lib/key-bindings.zsh"
# Add useful aliases and functions to work with git.
zinit snippet OMZ::plugins/git

AUTOENV_FILE_ENTER=autoenv-enter.zsh
AUTOENV_FILE_LEAVE=autoenv-leave.zsh
zinit load Tarrasch/zsh-autoenv

# Enable highlighing of commands whilst they are typed at a zsh prompt
# into an interactive terminal.
# zinit load zsh-users/zsh-syntax-highlighting

### End of Zinit's installer chunk

# Starship prompt.
eval "$(starship init zsh)"


# Setup fuzzy search with FZF {{{
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type f --exclude pCloud\ Drive"
export FZF_CTRL_T_COMMAND="fd --type f --exclude pCloud\ Drive"
# }}}
