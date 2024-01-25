local jdk_home = "/home/casret/.asdf/installs/java/zulu-11.52.13/"
return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = true,
    },
    servers = {
      eslint = {},
      kotlin_language_server = {
        cmd = { "/home/casret/bin/kotlin-language-server" },

        --        cmd_env = {
        --          JAVA_HOME = jdk_home,
        --          PATH = jdk_home .. "bin:" .. os.getenv("PATH"),
        --        },
      },
    },
    setup = {
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
  },
}
