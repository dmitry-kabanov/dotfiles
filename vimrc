" Use Vim settings, rather than Vi settings.
set nocompatible

call pathogen#infect()

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Turn on syntax highlighting.
syntax on

" For all text files set 'textwidth' to 80 characters.
autocmd FileType text setlocal textwidth=80

" Set backspace key to function as expected.
set backspace=indent,eol,start

" Indentation
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set smartindent

set number
set encoding=utf-8

" Set minimal number of screen lines to keep above and below the cursor.
set scrolloff=1

set backupdir=~/.vim/tmp
set dir=~/.vim/tmp

" Allow to switch between buffers even if the current buffer is modified.
set hidden

" Search options
if &t_Co > 2 || has("gui_running")
    set hlsearch
endif

" Turn on incremental search.
set incsearch

" Colorscheme
if $TERM == 'linux'
    set t_Co=16
    let g:solarized_termtrans=1
    let g:solarized_termcolors=16
endif
if $TERM == 'xterm'
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

" Font
if has("gui_macvim")
    set guifont=Menlo:h18
endif

if has("gui_gtk2")
    set guifont=Cousine\ 14
endif

set cursorline
if v:version >= 703
    set colorcolumn=80
endif

"" Statusline
"set statusline =%#identifier#
"set statusline+=[%t]    "tail of the filename
""display a warning if fileformat isnt unix
"set statusline+=%#warningmsg#
"set statusline+=%{&ff!='unix'?'['.&ff.']':''}
""display a warning if file encoding isnt utf-8
"set statusline+=%#warningmsg#
"set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
"" misc
"set statusline+=%#identifier#
"set statusline+=%h      "help file flag
"set statusline+=%y      "filetype
""read only flag
"set statusline+=%r
""modified flag
"set statusline+=%m
""set statusline+=%*
"set statusline+=%{fugitive#statusline()}
"set statusline+=%=      "left/right separator
"set statusline+=[col\ %c]     "cursor column
"set statusline+=\ [line\ %l/%L]   "cursor line/total lines

" Always show status line.
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

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

let g:syntastic_python_checkers=['pyflakes']

" Setup vim-airline plugin.
let g:airline_powerline_fonts = 1

" Set timeouts for key codes and mapped key sequences.
set timeout timeoutlen=3000 ttimeoutlen=50

" Turn off showing current mode in commdand line.
set noshowmode
