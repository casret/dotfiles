local opt = vim.opt -- to set options
opt.termguicolors = true
opt.background = "light"
opt.updatetime = 300
opt.cmdheight = 2
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.mouse = "a"
opt.foldenable = false
opt.directory = "/tmp"
opt.top = true
opt.hidden = true
opt.autowrite = true
opt.showmode = false
-- opt.clipboard = "unnamedplus"
opt.formatoptions = "tcroqj"
opt.title = true

vim.g.vim_json_syntax_conceal = 0

vim.cmd("colorscheme solarized")
vim.cmd("unmap Y")
