" Vim
" An example for a vimrc file.
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc

" fix a wierd gentoo bug
":if &term =~ "rxvt"
": set term=xterm
":endif

set nocompatible	" Use Vim defaults (much better!)
set bs=2		" allow backspacing over everything in insert mode
" set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers

set ruler
set wrap
set secure
set icon
set guioptions=alm
set incsearch
set showmatch
set tabstop=2
set shiftwidth=2
set expandtab
set showmode
set smartindent
set ignorecase
set smartcase
set top
set hidden
set makeprg=ant
set dir=~/tmp
set autowrite
runtime macros/matchit.vim

filetype plugin indent on

" Maps function keys to modes
map #1 :h
map #2 :nohl
map #3 :cn
map #4 :bn
map #5 :bd


" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  colorscheme desert
endif

"I need to fix this
"if has("autocmd")
"  augroup vimrcEX
"  au!
"  " In text files, always limit the width of text to 78 characters
"  "  autocmd FileType text setlocal textwidth=78
"  " When editing a file, always jump to the last cursor position
"  autocmd BufReadPost *
"  \ if line("'\"") > 0 && line("'\"") <= line("$") |
"  \   exe "normal g`\"" |
"  \ endif
"  augroup END
"
"	au BufNewFile,BufRead *.tmpl               set ft=html
"
" augroup cprog
"  " Remove all cprog autocommands
"  au!
"
"  " When starting to edit a file:
"  "   For C and C++ files set formatting of comments and set C-indenting on.
"  "   For other files switch it off.
"  "   Don't change the order, it's important that the line with * comes first.
"  autocmd FileType *      set formatoptions=tcql nocindent comments&
"  autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
" augroup END

" augroup javaprog
  " Remove all javaprog autocommands
"  au!
  
  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
"  autocmd FileType *      set formatoptions=tcql nocindent comments&
"  autocmd FileType java  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,:// cino=t0,(0

" augroup END
"endif 

"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1

command -bar -nargs=1 OpenURL :!firefox <args>

":nnoremap <silent> <F8> :Tlist<CR>:TMiniBufExplorer<CR>
" actionscript language
"let s:tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'

"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_ 
"set wmh=0
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

"let g:Tb_MapWindowNavVim = 1
"let g:Tb_MapWindowNavArrows = 1
"let g:Tb_MapCTabSwitchBufs = 1
"let g:Tb_UseSingleClick = 1
"let g:Tb_ModSelTarget = 1
"let g:Tb_TabWrap = 1
