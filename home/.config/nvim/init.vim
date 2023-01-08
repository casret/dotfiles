lua require('plugins')
lua require('mappings')
lua require('options')

let g:clipboard = {
                        \   'name': 'win32yank-wsl',
                        \   'copy': {
                        \      '+': 'win32yank.exe -i --crlf',
                        \      '*': 'win32yank.exe -i --crlf',
                        \    },
                        \   'paste': {
                        \      '+': 'win32yank.exe -o --lf',
                        \      '*': 'win32yank.exe -o --lf',
                        \   },
                        \   'cache_enabled': 0,
                        \ }
" when win32yank slow as hell
"let g:clipboard = {  'name': 'WslClipboard', 'copy': {  '+': 'clip.exe',  '*': 'clip.exe',  },  'paste': {  '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',  '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',  },  'cache_enabled': 0,  }
" let g:polyglot_disabled = ['jsx']
" In case we do end up wanting jsx
"let g:jsx_ext_required = 1

" checkout lualine
"let g:airline#extensions#coc#enabled = 1
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
"let g:tmuxline_preset = 'nightly_fox'

" figure out a better way to navigate
"map #2 :nohl<cr>
"map #3 :bp<cr>
"map #4 :bn<cr>
"map #5 :BD<cr>

"nmap <silent> <BS> :nohlsearch<CR>
"nnoremap <silent> <A-right> :bn<CR>
"nnoremap <silent> <A-left> :bp<CR>
"nnoremap Q <Nop>

"autocmd FileType c,cpp,java,php,javascript,vue,python autocmd BufWritePre <buffer> %s/\s\+$//e

"nnoremap <C-space> a
"imap <C-space> <Esc>

"nnoremap <C-@> a
"imap <C-@> <Esc>

