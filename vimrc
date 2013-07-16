set nocompatible

call pathogen#infect()
filetype plugin indent on
" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78

" Indentation
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent

set number
set encoding=utf-8

autocmd FileType make setlocal noexpandtab

set backupdir=~/.vim/tmp
set dir=~/.vim/tmp

" Turn on syntax highlighting
if &t_Co > 2 || has("gui_running")
    syntax on
endif

" Search options
if &t_Co > 2 || has("gui_running")
    set hlsearch
endif
set incsearch " incremental search

" Colorscheme
if $TERM == 'linux'
    set t_Co=16
    let g:solarized_termtrans=1
    let g:solarized_termcolors=16
endif
if $COLORTERM == 'gnome-terminal'
    let g:solarized_termtrans=1
endif
if $TERM == 'screen-256color'
    let g:solarized_termtrans=1
endif
set background=dark
colorscheme solarized
    
" Statusline
set statusline =%#identifier#
set statusline+=[%t]    "tail of the filename
"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
" misc
set statusline+=%#identifier#
set statusline+=%h      "help file flag
set statusline+=%y      "filetype
"read only flag
set statusline+=%r
"modified flag
set statusline+=%m
"set statusline+=%*
set statusline+=%{fugitive#statusline()}
set statusline+=%=      "left/right separator
set statusline+=[col\ %c]     "cursor column
set statusline+=\ [line\ %l/%L]   "cursor line/total lines
set laststatus=2

" Shortcut for rapidly toggle 'set list'
nmap <leader>l :set list!<CR>
" Custom symbols for invisible symbols such as tab and EOL
set listchars=tab:»\ ,eol:¬

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

set wildignore+=*.o     " ignore .o   files for filename completion
