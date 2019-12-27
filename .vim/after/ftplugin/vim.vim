" Conform to VimL conventions for two-space indentation.
setlocal shiftwidth=2
setlocal softtabstop=2

let b:undo_ftplugin .= '|setlocal shiftwidth<'
let b:undo_ftplugin .= '|setlocal softtabstop<'
