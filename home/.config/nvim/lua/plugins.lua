return {
  {
    'ishan9299/nvim-solarized-lua',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme solarized]])
    end
  },
  {'folke/which-key.nvim',
    config = true,
    event = "VeryLazy",
  },
  {'tpope/vim-sleuth',
    lazy = false,
  },
  {'tpope/vim-surround',
    event = "BufEnter",
  },
  {'sitiom/nvim-numbertoggle',
    event = "BufNew",
  },
  {'rmagatti/auto-session',
    lazy = false,
    -- opts = {log_level = "debug"},
    -- auto-session loads up some statuscol local
    dependencies = {
      {"luukvbaal/statuscol.nvim",
        opts = { setopt = true },
        dependencies = { {"lewis6991/gitsigns.nvim", config = true} },
        config = true,
      },
    },
    config = true
  },
  {
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
}
