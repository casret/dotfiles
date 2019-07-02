" Setup your python pyenvs as in https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim#using-virtual-environments

let g:python3_host_prog = $HOME . '/.pyenv/versions/neovim3/bin/python'
let g:python_host_prog = $HOME . '/.pyenv/versions/neovim2/bin/python'

let g:mapleader="\<Space>"
let g:maplocalleader=';'

let g:polyglot_disabled = ['jsx']
" In case we do end up wanting jsx
"let g:jsx_ext_required = 1
set termguicolors

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  " call dein#add('nixprime/cpsm')
  call dein#add('raghur/fruzzy', {'hook_post_update': 'call fruzzy#install()'})
  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('chemzqm/unite-location')

  " call dein#add('907th/vim-auto-save')

  call dein#add('sheerun/vim-polyglot')
  call dein#add('zchee/vim-flatbuffers')

  call dein#add('icymind/NeoSolarized')

  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/context_filetype.vim')
  call dein#add('Shougo/neopairs.vim')
  call dein#add('Shougo/echodoc.vim')
  call dein#add('Shougo/neoinclude.vim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('tweekmonster/deoplete-clang2')
"  call dein#add('zchee/deoplete-jedi')
  call dein#add('deathlyfrantic/deoplete-spell')
  call dein#add('wokalski/autocomplete-flow')
"  call dein#add('jiangmiao/auto-pairs')
"  call dein#add('ervandew/supertab')
"  call dein#add('sebastianmarkow/deoplete-rust', { 'on_ft': 'rust'})

  call dein#add('tpope/vim-sleuth')

  call dein#add('tpope/vim-surround')

  call dein#add('w0rp/ale')

  call dein#add('autozimu/LanguageClient-neovim', {
        \ 'rev': 'next',
        \ 'build': 'bash install.sh',
        \ })

  call dein#add('vim-airline/vim-airline')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

if dein#tap('denite.nvim')
  " Define mappings
  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
          \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
          \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
          \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
          \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
          \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
          \ denite#do_map('toggle_select').'j'
  endfunction

  autocmd FileType denite-filter call s:denite_filter_my_settings()
	function! s:denite_filter_my_settings() abort
	  inoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	  call deoplete#custom#buffer_option('auto_complete', v:false)
	  imap <silent><buffer> <C-c> <Plug>(denite_filter_quit)
	  inoremap <silent><buffer> <Down>
	  \ <Esc><C-w>p:call cursor(line('.')+1,0)<CR><C-w>pA
	  inoremap <silent><buffer> <Up>
	  \ <Esc><C-w>p:call cursor(line('.')-1,0)<CR><C-w>pA
	endfunction

  call denite#custom#option('_', {
        \ 'start_filter': v:true,
        \ 'prompt': 'λ:',
        \ 'empty': v:false,
        \ 'source_names': 'short',
        \ 'vertical_preview': 1,
        \ 'auto_resume': v:true,
        \ 'split': "no",
        \ 'immediately_1': v:true,
        \ 'statusline': v:false,
        \ })

  call denite#custom#alias('source', 'file/rec/git', 'file/rec')

  call denite#custom#var('file/rec/git', 'command',
        \ ['git', 'ls-files', '-co', '--exclude-standard', '--cached', '--others'])


  let g:fruzzy#usenative = 1
  call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])

  call denite#custom#source('file/rec', 'sorters', ['sorter/sublime'])
  call denite#custom#source('file/rec/git', 'sorters', ['sorter/sublime'])

  " FIND and GREP COMMANDS
  if executable('rg')
    call denite#custom#var('file_rec', 'command',
          \ ['rg', '--files'])

    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
  elseif executable('pt')
    call denite#custom#var('file/rec', 'command',
          \ ['pt', '--follow', '--nocolor', '--nogroup',
          \  (has('win32') ? '-g:' : '-g='), ''])

    call denite#custom#var('grep', 'command', ['pt'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--nogroup', '--nocolor', '--smart-case'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

  elseif executable('ag')
    " The Silver Searcher
    call denite#custom#var('file/rec', 'command',
          \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

    call denite#custom#var('grep', 'command', ['ag'])
    call denite#custom#var('grep', 'default_opts',
          \ ['-i', '--vimgrep'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
  elseif executable('ack')
    call denite#custom#var('grep', 'command', ['ack'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--ackrc', $HOME.'/.ackrc', '-H',
          \  '--nopager', '--nocolor', '--nogroup', '--column'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--match'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
  endif

"  call denite#custom#map(
"        \ 'insert',
"        \ '<Down>',
"        \ '<denite:move_to_next_line>',
"        \ 'noremap'
"        \)
"  call denite#custom#map(
"        \ 'insert',
"        \ '<Up>',
"        \ '<denite:move_to_previous_line>',
"        \ 'noremap'
"        \)

  nnoremap <silent><leader>t :<C-u>Denite
        \ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>

  nnoremap <silent><leader>st :<C-u>Denite -default-action=split
        \ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>

  nnoremap <silent><leader>vt :<C-u>Denite -default-action=vsplit
        \ `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'`<CR>

  nnoremap <silent><leader>g :<C-u>Denite grep<CR>

  if dein#tap('neomru.vim')
    nnoremap <silent><leader>r :<C-u>Denite -buffer-name=files file_mru<CR>
    nnoremap <silent><leader>sr :<C-u>Denite -buffer-name=files -default-action=split file_mru<CR>
    nnoremap <silent><leader>vr :<C-u>Denite -buffer-name=files -default-action=vsplit file_mru<CR>
  endif

  if dein#tap('unite-location')
    nnoremap <silent><leader>p  :<C-u>Denite -resume<CR>
    nnoremap <silent><leader>j  :call execute('Denite -resume -select=+'.v:count1.' -immediately')<CR>
    nnoremap <silent><leader>k  :call execute('Denite -resume -select=-'.v:count1.' -immediately')<CR>
    nnoremap <silent><leader>q  :<C-u>Denite -mode=normal -auto-resize quickfix<CR>
    nnoremap <silent><leader>l  :<C-u>Denite -mode=normal -auto-resize location_list<CR>
  endif

endif

if dein#tap('NeoSolarized')
  colorscheme NeoSolarized
  set background=light
endif

if dein#tap('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
  set completeopt-=preview
  let g:neosnippet#enable_completed_snippet = 1
  let g:echodoc_enable_at_startup = 1

  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)

  " SuperTab like snippets' behavior.
  " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
  imap <expr><TAB>
        \ pumvisible() ? "\<C-n>" :
        \ neosnippet#expandable_or_jumpable() ?
        \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  " For conceal markers.
  "if has('conceal')
  "  set conceallevel=2 concealcursor=niv
  "endif

  " Expand the completed snippet trigger by <CR>.
  imap <expr><CR>
        \ (pumvisible() && neosnippet#expandable()) ?
        \ "\<Plug>(neosnippet_expand)" : "\<CR>"
endif

if dein#tap('ale')
  let g:ale_linters = {
        \   'javascript': ['eslint', 'flow'],
        \   'kotlin' : ['ktlint'],
        \}
  "kotlinc is broken for me
  let g:ale_kotlin_kotlinc_enable_config = 1
  let g:ale_kotlin_kotlinc_options = '-jvm-target 1.8 -d ~/tmp'
  "let g:ale_kotlin_languageserver_executable = '/Users/casret/git/KotlinLanguageServer/build/install/kotlin-language-server/bin/kotlin-language-server'
  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

endif

if dein#tap('deoplete-rust')
  let g:deoplete#sources#rust#racer_binary= system('which racer')[:-2]
  let g:deoplete#sources#rust#rust_source_path=system('rustc --print sysroot')[:-2] . '/lib/rustlib/src/rust/src'
endif




set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set ignorecase
set smartcase
set smartindent
set mouse=a
map #2 :nohl<cr>
map #3 :ALEFix<cr>
map #4 :bn<cr>

nmap <silent> <BS> :nohlsearch<CR>
nnoremap <silent> <A-right> :bn<CR>
nnoremap <silent> <A-left> :bp<CR>
nnoremap Q <Nop>
nnoremap <C-space> a
imap <C-space> <Esc>

set termguicolors
set nofoldenable
set dir=~/tmp
set top
set hidden
set autowrite

set noshowmode
set clipboard+=unnamedplus "copy and paste to the system clipboard
set formatoptions=tcroqj

autocmd FileType c,cpp,java,php,javascript,vue,python autocmd BufWritePre <buffer> %s/\s\+$//e
let g:vim_json_syntax_conceal = 0
nnoremap <C-space> a
imap <C-space> <Esc>

nnoremap <C-@> a
imap <C-@> <Esc>

let g:LanguageClient_serverCommands = {
      \ 'javascript': ['npx', 'javascript-typescript-stdio'],
      \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
      \ }
"    \ 'kotlin': ['/Users/casret/git/KotlinLanguageServer/server/build/install/server/bin/server'],
