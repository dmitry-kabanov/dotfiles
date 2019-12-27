" Indentation
set tabstop=4
set noexpandtab
set softtabstop=4
set shiftwidth=4

setlocal list
setlocal listchars=tab:>>

let b:undo_ftplugin .= '|setlocal listchars<'
let b:undo_ftplugin .= '|setlocal list<'
