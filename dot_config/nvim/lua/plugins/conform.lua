return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      kotlin = { "ktfmt" },
    },
    formatters = {
      ktfmt = {
        command = "java",
        args = {
          "-jar",
          "/home/casret/bin/ktfmt-0.46/core/target/ktfmt-0.46-jar-with-dependencies.jar",
          "--stdin-name=$FILENAME",
          "-",
        },
      },
    },
  },
}
