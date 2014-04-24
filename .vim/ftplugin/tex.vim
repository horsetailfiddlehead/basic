" customization file for Patrick

" set the default compile format to pdf
let g:Tex_DefaultTargetFormat='pdf'

" add pdf support to multi-compiling
let g:Tex_MultipleCompileFormats='dvi,pdf'

" set the default colorscheme to 'slate'
if has('gui_running') " in gVim
	colorscheme solarized
else
	colorscheme slate
endif

" autex mappings

" insert a \item
imap <buffer> EIT <Plug>Tex_InsertItemOnThisLine

" In Windows, use a different pdf viewer
"if has('win32')
"	let g:Tex_ViewRule_pdf = 'xpdf'
"endif

" usually I want figures to have a specified size
let g:Tex_Env_figure = "\\begin{figure}[<+htpb+>]\<CR>\\centering\<CR>\\includegraphics[<+width,height+>]{<+file+>}\<CR>\\caption{<+caption text+>}\<CR>\\label{fig:<+label+>}\<CR>\\end{figure}<++>"
