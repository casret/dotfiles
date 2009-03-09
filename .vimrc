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
set smarttab

set showmode
set smartindent
set ignorecase
set smartcase
set top
set hidden
set makeprg=ant
set dir=~/tmp
set mouse=a
set ttymouse=xterm2
set autowrite
runtime macros/matchit.vim

set grepprg=ack
set grepformat=%f:%l:%m

filetype plugin indent on

let g:fuzzy_ignore = "*.log"
let g:fuzzy_matching_limit = 70

let mapleader = ","

" Maps function keys to modes
map #1 :h
map #2 :nohl
map #3 :cn
map #4 :bn
map #5 :bd
nmap <Tab> :FuzzyFinderTextMate<CR>
map <leader>b :FuzzyFinderBuffer<CR>

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  let g:zenburn_high_Contrast = 1
  colorscheme zenburn
endif

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
