local km = vim.keymap
vim.g.mapleader = " "
vim.g.maplocalleader = ";"
km.set('n', '<leader>p', '"+p', { noremap = true })
km.set('n', '<leader>y', '"+y', { noremap = true })
