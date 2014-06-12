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

" Always show status line.
set laststatus=2

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

nnoremap j gj
nnoremap k gk

" Options for CtrlP plugin.
let g:ctrlp_cmd = 'CtrlP'

" Options for syntastic plugin.
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_aggregate_error = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '✗'
let g:syntastic_stl_format = 'Syntastic: %F (%t)'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_tex_checkers = ['lacheck']

" Setup vim-airline plugin.
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = '⎇'
function! AirlineInit()
    let g:airline_section_z = "%3p%% %#__accent_bold#%4l%#__restore__#:%3c"
    " Add reminder %k when keymap is turned on.
    let g:airline_section_warning = airline#section#create(['syntastic', 'whitespace', '%k'])
endfunction
autocmd VimEnter * call AirlineInit()

" Options for ultisnips plugin.
let g:UltiSnipsExpandTrigger="<C-@>"
let g:UltiSnipsJumpForwardTrigger = "<C-@>"
let g:UltiSnipsJumpBackwardTrigger = "<C-S-@>"
noremap <Leader>lus :<C-R>=UltiSnips_ListSnippets()<CR>

" Set timeouts for key codes and mapped key sequences.
set timeout timeoutlen=3000 ttimeoutlen=50

" Turn off showing current mode in command line.
set noshowmode

" Options for Latex-Box plugin.
let g:LatexBox_latexmk_async = 0
let g:LatexBox_latexmk_preview_continuously = 1
" Quickfix window is opened automatically if not empty
" but cursor stays in current window.
let g:LatexBox_quickfix = 2
let g:LatexBox_output_type = "pdf"
let g:LatexBox_viewer = "open -a Skim"

" Options for tmuxline.vim.
let g:tmuxline_preset = {
      \'a'    : '#S',
      \'b'    : '',
      \'c'    : '',
      \'win'  : '#I #W',
      \'cwin' : '#I #W',
      \'x'    : '',
      \'y'    : '#(whoami)',
      \'z'    : '#H'}
let g:tmuxline_powerline_separators = 0

" Options for YouCompleteMe.
if has("unix")
    let g:ycm_path_to_python_interpreter = '/usr/bin/python2'
endif
if has("mac")
    let g:ycm_path_to_python_interpreter = '/usr/bin/python'
endif
