"
" vim:fdm=marker

" Preamble - nocompatible {{{
" Use Vim settings, rather than Vi settings.
set nocompatible
filetype off                  " required
" }}}

" Plugins (managed by vim plug) {{{
" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

Plug 'Valloric/YouCompleteMe'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/syntastic'
Plug 'majutsushi/tagbar'
Plug 'junegunn/vim-easy-align'

Plug 'bling/vim-airline'

" Snippets.
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Turn on CAPS LOCK.
Plug 'tpope/vim-capslock'

" Color schemes.
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'chriskempson/base16-vim'

" Git integration.
Plug 'tpope/vim-fugitive'

" Fix python indentation.
Plug 'hynek/vim-python-pep8-indent'

" Plugins that improve support of different file types.
Plug 'drmingdrmer/vim-syntax-markdown'  " markdown support
Plug 'lervag/vimtex'  " latex support
Plug 'tmux-plugins/vim-tmux' " syntax highlighting for `.tmux.conf`

" Add plugins to &runtimepath.
call plug#end()
" }}}

" Options for the editor itself {{{
" Enable file type detection and do language-dependent indenting.
filetype plugin indent on

" Turn on syntax highlighting.
syntax on

" For all text files set 'textwidth' to 80 characters.
autocmd FileType text setlocal textwidth=80

" Backspace over autoindent, line breaks, start of insert.
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
if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

" Font
if has("gui_macvim")
    set guifont=Menlo:h18
endif

if has("gui_gtk2")
    set guifont=Cousine\ 14
endif

set cursorline
if exists("+colorcolumn")
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

" Set timeouts for key codes and mapped key sequences.
set timeout timeoutlen=3000 ttimeoutlen=50
" }}}

" Options for CtrlP {{{
let g:ctrlp_cmd = 'CtrlP'
" }}}

" Options for syntastic {{{
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_error = 1
let g:syntastic_stl_format = 'Syntastic: %F (%t)'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_tex_checkers = ['lacheck']
" }}}

" Options for ultisnips {{{
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger = "<C-@>"
let g:UltiSnipsJumpBackwardTrigger = "<C-S-@>"
noremap <Leader>lus :<C-R>=UltiSnips_ListSnippets()<CR>
" }}}

" Options for Latex-Box plugin {{{
let g:LatexBox_latexmk_async = 0
let g:LatexBox_latexmk_preview_continuously = 1
" Quickfix window is opened automatically if not empty
" but cursor stays in current window.
let g:LatexBox_quickfix = 2
let g:LatexBox_output_type = "pdf"
let g:LatexBox_viewer = "open -a Skim"
" }}}

" Options for YouCompleteMe {{{
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_path_to_python_interpreter = "/usr/bin/python"
" }}}

" Options for vim-airline {{{
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
" }}}

" Options for vimtex {{{
let g:vimtex_fold_enabled = 0
" }}}
