" Text width
setlocal textwidth=79

" Indentation
set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4

" Autoindentation
setlocal autoindent

" ALE Settings
let b:ale_python_mypy_options = "--ignore-missing-imports"
let b:ale_fixers = ["isort", "black"]

nnoremap gd :YcmCompleter GoToType<CR>
