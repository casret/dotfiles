-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- Using callback to set conceallevel
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  --pattern = {"*.json", "*.md"},
  callback = function()
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_option(win, "conceallevel", 0)
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  --pattern = {"*.json", "*.md"},
  callback = function()
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_option(win, "conceallevel", 3)
  end,
})
