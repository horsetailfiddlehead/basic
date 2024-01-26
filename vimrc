" An example for a vimrc file.
"
" Maintainer:  Patrick Ma	
" Last change:	2014 Apr 19
"
" Taken originally from: Bram Moolenaar's example vimrc
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" MyDiff is required for VimDiff on Windows machines
if has("Win32")
	set diffexpr=MyDiff()
	function MyDiff()
	  let opt = '-a --binary '
	  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	  let arg1 = v:fname_in
	  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	  let arg2 = v:fname_new
	  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	  let arg3 = v:fname_out
	  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	  if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
		  if empty(&shellxquote)
			let l:shxq_sav = ''
			set shellxquote&
		  endif
		  let cmd = '"' . $VIMRUNTIME . '\diff"'
		else
		  let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	  else
		let cmd = $VIMRUNTIME . '\diff'
	  endif
	  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
	  if exists('l:shxq_sav')
		let &shellxquote=l:shxq_sav
	  endif
	endfunction
endif


" "  My additions below ""
"----------------------------------------
" Adjust Git commit message diff colors
" From https://stackoverflow.com/a/74153391
" Note: must be defined before any colorschemes
function! DiffHighlights() abort
    highlight diffAdded ctermfg=2 guifg=#67c12c
    highlight diffRemoved ctermfg=1 guifg=#b82e19
		highlight diffChanged ctermfg=3 guifg=#b89e19
endfunction
augroup BetterDiffColors
    autocmd!
    autocmd ColorScheme * call DiffHighlights()
augroup END

" Set background to improve readbility and the default colorscheme
set background=dark
colorscheme desert

" Generally, terminals support 256 colors, but only claim 8
if &t_Co > 2 || has("gui_running")
	set t_Co=256
endif


" I like line numbers and the ruler
set number
set laststatus=2

" This toggles relative numbers automatically.
" See https://jeffkreeftmeijer.com/vim-number/
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
:  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
:augroup END

" Set the font for GUI windows
set guifont=Lucida_Console:h10:cANSI:qDRAFT

" set the tabstop for easier reading
set tabstop=2

" set visual indicator of ideal line length
set colorcolumn=80
" set line length indicator color
highlight colorcolumn ctermbg=100 guibg=darkgrey

" set the default window size (for non-CLI windows)
if has('gui_running')
	set columns=90
	set lines=40
endif

" set whitespace marks. Visible using 'set list'
set listchars=eol:¶,trail:Þ,tab:»-,extends:>,precedes:<,space:·

" add clear search highlight ability to normal screen clear
nnoremap <C-l> :nohlsearch<CR><C-l>

" map command bclose (or bc) to close current buffer, but not window
nmap <leader>bc :bn<bar>bd#<CR>

" trim a line to default length
nnoremap <leader>f gqhj
" trim all lines to vim's default line length
nmap <leader>fa <leader>f<leader>fa

" nifty command to see the difference between a loaded file and the newest
" version on disk
" Use this command by typing :DiffOrig
" To load original, type :e! :only
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Folding settings
" --------------------------------------
" Defines vim folding option as 'indent', but also allows manual folding
augroup setFolding
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

set foldlevelstart=20
"===============================================================================

" C/C++ code-specific settings"
" ---------------------------------------
"
set cinoptions=l1 " override default indenting rule to 1 tab

" vim-latex settings "
" ---------------------------------------
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:
"===============================================================================

" YAML file settings "
"-----------------------------------------
autocmd Filetype yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

"===============================================================================

" Set and create backup and swap directories as needed
if &backup
	set backupdir=$HOME/.vim/.backup//
	if !isdirectory(&backupdir)
		call mkdir(&backupdir, "p")
	endif
endif
set directory=$HOME/.vim/.swap//
if !isdirectory(&directory)
	call mkdir(&directory, "p")
endif

" Set VimDiff options
if &diff
	" map ']' and '[' to jump to next/prev diff
	map ] ]c
	map [ [c
endif
