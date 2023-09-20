return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    ---@type TSConfig
    opts = {
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true ,
        disable = {"ruby"}
      },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = { "bash", "dockerfile", "diff", "go", "javascript", "lua", "markdown", "python","rust", "typescript", "vue", "yaml", "pug" },
      auto_install = true,
    },
    ---@param opts TSConfig
    config = function(plugin, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
