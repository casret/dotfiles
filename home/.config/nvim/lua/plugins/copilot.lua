return {
  { "zbirenbaum/copilot.lua",
    lazy = true,
    opts = {
      suggestion = {
	enabled = false,
      },
      panel = {
	enabled = false,
      },
    },
    config = true
  },
  { "zbirenbaum/copilot-cmp",
    dependencies = "zbirenbaum/copilot.lua",
    lazy = true,
    config = true
  },
}
