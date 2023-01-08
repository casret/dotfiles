local cmp = require("cmp")
local lspkind = require("lspkind")

--local has_words_before = function()
--local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--end

local cmp = require'cmp'

-- copilot version https://github.com/zbirenbaum/copilot-cmp
local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 50,
    }),
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
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
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    -- copilot version
    ["<Tab>"] = vim.schedule_wrap(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end),
    --["<Tab>"] = cmp.mapping(function(fallback)
    --  if cmp.visible() then
    --    cmp.select_next_item()
    --  elseif has_words_before() then
    --    cmp.complete()
    --  else
    --    fallback()
    --  end
    --end, {
    --  "i",
    --  "s",
    --}),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = cmp.config.sources({
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "buffer" },
    { name = "path" },
  }),
  experimental = {
    -- native_menu = false,
    ghost_text = true,
  },
  window = {
    documentation = cmp.config.window.bordered(),
  },
})

-- only enable nvim_lsp in lua files
--vim.cmd(
--  [[ autocmd FileType lua lua require'cmp'.setup.buffer { sources = { { name = 'buffer' },{ name = 'nvim_lua'},{name = "nvim_lsp"}},} ]]
--)

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
