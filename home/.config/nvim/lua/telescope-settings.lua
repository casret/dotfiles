-- most of this is default settings
local telescope = require("telescope")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>t', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

telescope.setup()
telescope.load_extension("fzy_native")
