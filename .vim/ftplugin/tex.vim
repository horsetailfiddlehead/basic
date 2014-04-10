" customization file for Patrick

" set the default compile format to pdf
let g:Tex_DefaultTargetFormat='pdf'

" add pdf support to multi-compiling
let g:Tex_MultipleCompileFormats='dvi,pdf'

" set the default colorscheme to 'slate'
colorscheme solarized

" autex mappings

" insert a \item
imap <buffer> EIT <Plug>Tex_InsertItemOnThisLine
