-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'sheerun/vim-polyglot'  
  use 'lifepillar/vim-solarized8'
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'tpope/vim-sleuth'
  use 'tpope/vim-surround'
  use 'tpope/vim-obsession'

  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'qpkorr/vim-bufkill'
  use 'farmergreg/vim-lastplace'
  use 'edkolev/tmuxline.vim'
  use 'github/copilot.vim'
  use 'tpope/vim-repeat'
  use 'ggandor/lightspeed.nvim'

  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-treesitter/nvim-treesitter"}
    }
  }
end)
