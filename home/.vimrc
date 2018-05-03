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

execute pathogen#infect()
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
set makeprg=rake
set dir=~/tmp
set mouse=a
if !has('nvim')
  set ttymouse=xterm2
endif
set autowrite
set wildmode=longest:full,list
runtime macros/matchit.vim
set termguicolors

set nofoldenable

" set grepprg=ack\ --nosql
" set grepformat=%f:%l:%m

filetype plugin indent on

"let g:fuzzy_ignore = "*.log,*.class,gems/gems/**"
"let g:fuzzy_matching_limit = 70

let mapleader = " "

" Maps function keys to modes
map #1 :h
map #2 :nohl
map #3 :cn
map #4 :bn
"map #5 :bd
"call togglebg#map("<F5>")
"nmap <Tab> :FuzzyFinderTextMate<CR>
"map <leader>b :FuzzyFinderBuffer<CR>
"map <leader>r :FuzzyFinderTextMateRefreshFiles<CR>

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
"  let g:zenburn_high_Contrast = 1
  set background=light
  colorscheme NeoSolarized
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

:highlight RedundantSpaces ctermbg=red guibg=red
:match RedundantSpaces /\s\+$\| \+\ze\t/

"let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files']
"let g:ctrlp_map = '<Tab>'
"let g:ctrlp_by_filename = 1
set laststatus=2
" Unite
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>t :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/git:--cached:--others:--exclude-standard<cr>
nnoremap <leader>tv :<C-u>Unite -no-split -buffer-name=files   -start-insert -default-action=vsplit file_rec/git:--cached:--others:--exclude-standard<cr>
nnoremap <leader>ts :<C-u>Unite -no-split -buffer-name=files   -start-insert -default-action=split file_rec/git:--cached:--others:--exclude-standard<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>
nnoremap <leader>g :<C-u>Unite -no-split -buffer-name=search-buffer grep:. <cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction

if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif

" pymode
let g:pymode_folding = 0

" remove trailing withspace
autocmd FileType c,cpp,java,php,javascript,vue autocmd BufWritePre <buffer> %s/\s\+$//e

