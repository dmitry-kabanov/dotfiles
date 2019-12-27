" Indentation
setlocal tabstop=4
setlocal noexpandtab
setlocal softtabstop=4
setlocal shiftwidth=4

setlocal list
setlocal listchars=tab:>>

let b:undo_ftplugin .= '|setlocal listchars<'
let b:undo_ftplugin .= '|setlocal list<'
