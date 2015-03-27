" Use Vim settings, rather than Vi settings.
set nocompatible
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kien/ctrlp.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'morhetz/gruvbox'
Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-capslock'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-fugitive'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'bling/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required

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

set number
set encoding=utf-8

" Set minimal number of screen lines to keep above and below the cursor.
set scrolloff=1

set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//

" Allow to switch between buffers even if the current buffer is modified.
set hidden

" Enable visual bell instead of beepeing
set visualbell

" Search options
if &t_Co > 2 || has("gui_running")
    set hlsearch
endif

" Turn on incremental search.
set incsearch

" Use smart detection of case-sensitive or case-insensitive search.
set ignorecase
set smartcase

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

" Map <Leader> key to <Space> key
let mapleader = "\<Space>"

nmap <Leader>s :update<CR>

" Shortcut for rapidly toggle 'set list'
nmap <Leader>l :set list!<CR>
" Custom symbols for invisible symbols such as tab and EOL
set listchars=tab:»\ ,eol:¬

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

" Show partial command in the last line of the screen.
set showcmd

" Ignore .o files for filename completion
set wildignore+=*.o
set wildignore+=*.pyc

" Stop showing annoying preview window during autocompletion.
set completeopt-=preview

set keymap=russian-jcukengost
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=yellow

set spell
set spelllang=en_us,ru

nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

set wildmenu
set wildmode=full

nnoremap <Leader>z :nohlsearch<CR>

" Emacs-style editing on the command line.
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-D> <Del>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
cnoremap <Esc><C-B> <S-Left>
cnoremap <Esc><C-F> <S-Right>

" Always show status line.
set laststatus=2

" Turn off showing current mode in command line.
set noshowmode

" Options for CtrlP plugin.
let g:ctrlp_cmd = 'CtrlP'

" Options for syntastic plugin.
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_error = 1
let g:syntastic_stl_format = 'Syntastic: %F (%t)'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_tex_checkers = ['lacheck']

" Options for ultisnips plugin.
let g:UltiSnipsExpandTrigger="<C-@>"
let g:UltiSnipsJumpForwardTrigger = "<C-@>"
let g:UltiSnipsJumpBackwardTrigger = "<C-S-@>"
noremap <Leader>lus :<C-R>=UltiSnips_ListSnippets()<CR>

" Set timeouts for key codes and mapped key sequences.
set timeout timeoutlen=3000 ttimeoutlen=50

" Options for Latex-Box plugin.
let g:LatexBox_latexmk_async = 0
let g:LatexBox_latexmk_preview_continuously = 1
" Quickfix window is opened automatically if not empty
" but cursor stays in current window.
let g:LatexBox_quickfix = 2
let g:LatexBox_output_type = "pdf"
let g:LatexBox_viewer = "open -a Skim"

" Options for YouCompleteMe.
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_path_to_python_interpreter = 'python'

" Options for vim-airline
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_powerline_fonts=0
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'SV',
  \ '' : '^V',
  \ 's'  : 'S',
  \ 'S'  : 'SS',
  \ '' : '^S',
  \ }
