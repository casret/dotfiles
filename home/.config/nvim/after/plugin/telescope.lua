-- most of this is default settings
local telescope = require("telescope")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>t', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set("n", "<leader><leader>", "<Cmd>lua require('telescope').extensions.frecency.frecency({ workspace = 'CWD' })<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<leader>lr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, {})
vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, {})



telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = require("telescope.actions").close,
      },
    },
  },
}
telescope.load_extension("fzy_native")
