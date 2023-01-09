return {
  {
  event = "BufReadPre",
  'VonHeikemen/lsp-zero.nvim',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},
      {'onsails/lspkind.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      -- Snippet Collection (Optional)
      {'rafamadriz/friendly-snippets'},
    },
  config = function(plugin, opts)
    vim.opt.signcolumn = 'yes'
    local lsp = require('lsp-zero')
    local lspkind = require('lspkind')

    lsp.setup_nvim_cmp({
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
            symbol_map = {
              Copilot = "",
            }
          })
        }
      })

      lsp.preset('recommended')
      lsp.configure('solargraph', {
        force_setup = true
      })

      lsp.setup()
    end
  }
}
