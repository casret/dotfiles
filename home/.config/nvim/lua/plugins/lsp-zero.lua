-- copilot version https://github.com/zbirenbaum/copilot-cmp
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

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
      { "zbirenbaum/copilot-cmp" },
    },
    config = function(plugin, opts)
      vim.opt.signcolumn = 'yes'
      local lsp = require('lsp-zero')
      lsp.preset('recommended')
      local lspkind = require('lspkind')
      local cmp = require'cmp'

      local cmp_mappings = lsp.defaults.cmp_mappings({
        ["<C-Space>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item()
            else
              cmp.confirm()
            end
          else
            fallback()
          end
        end, {"i", "s", "c"}),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
      })

      lsp.setup_nvim_cmp({
        mapping = cmp_mappings,
        sources = {
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol', -- show only symbol annotations
            symbol_map = {
              Copilot = "",
            }
          })
        }
      })

      lsp.configure('solargraph', {
        force_setup = true
      })

      lsp.setup()
    end
  }
}
