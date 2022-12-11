-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'ishan9299/nvim-solarized-lua'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzy-native.nvim'} }
  }

  use({
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
    })

  use {
    'neovim/nvim-lspconfig',
    requires = { {"lukas-reineke/lsp-format.nvim"}}
  }
  use 'simrat39/rust-tools.nvim'
  use 'jose-elias-alvarez/typescript.nvim'

  use({
      "hoob3rt/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })

use {
  "zbirenbaum/copilot.lua",
  event = "VimEnter",
  config = function()
    vim.defer_fn(function()
      require("copilot").setup({
      suggestion = {
	auto_trigger = true,
        keymap = {
          accept = "<C-Space>",
        },
      }
      })
    end, 100)
  end,
}
use {
  "zbirenbaum/copilot-cmp",
  after = { "copilot.lua" },
  config = function ()
    require("copilot_cmp").setup()
  end
}
  use({
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" }
      }})

    use({
      "L3MON4D3/LuaSnip",
      requires = {
        "rafamadriz/friendly-snippets",
      },
    })

  use 'tpope/vim-sleuth'
  use 'tpope/vim-surround'

  use 'onsails/lspkind-nvim'
  use("mhartington/formatter.nvim")
     use({
      "weilbith/nvim-code-action-menu",
      cmd = "CodeActionMenu",
    })

  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }


  -- use 'edkolev/tmuxline.vim'
  -- use 'sheerun/vim-polyglot'  
  --use {'neoclide/coc.nvim', branch = 'release'}
  --use 'tpope/vim-obsession'

  --use 'vim-airline/vim-airline'
  --use 'vim-airline/vim-airline-themes'
  --use 'qpkorr/vim-bufkill'
  --use 'farmergreg/vim-lastplace'
  --use 'tpope/vim-repeat'
  --use 'ggandor/lightspeed.nvim'

  --use {
  --  "ThePrimeagen/refactoring.nvim",
  --  requires = {
  --    {"nvim-lua/plenary.nvim"},
  --    {"nvim-treesitter/nvim-treesitter"}
  --  }
 -- }

  --use 'github/copilot.vim'
end)
