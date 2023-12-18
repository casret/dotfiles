-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.termguicolors = true
opt.background = "light"
opt.wrap = true
vim.cmd("unmap Y")
vim.g.clipboard = {
  name = "WslClipboard",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}
opt.title = true
opt.titlestring = " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
vim.api.nvim_create_autocmd("DirChanged", {
  command = 'let &titlestring = " " .. fnamemodify(getcwd(), ":t")',
})
