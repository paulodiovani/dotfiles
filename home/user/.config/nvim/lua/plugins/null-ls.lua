return {
  "nvimtools/none-ls.nvim",
  commit = "7f9301e",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",

  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.codespell.with({ disabled_filetypes = { "markdown", "tex" } }),
        null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylelint,
      },
    })
  end,
}
