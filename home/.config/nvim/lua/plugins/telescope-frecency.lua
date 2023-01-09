return {
{
  "nvim-telescope/telescope-frecency.nvim",
  keys = {"<leader><leader>"},
  dependencies = {"kkharji/sqlite.lua"},
  config = function()
	  require"telescope".load_extension("frecency")
	  vim.keymap.set("n", "<leader><leader>", "<Cmd>lua require('telescope').extensions.frecency.frecency({ workspace = 'CWD' })<CR>", {noremap = true, silent = true})
  end,
  }
  }
