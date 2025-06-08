return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.codespell.with({ disabled_filetypes = { "markdown", "tex" } }),
        null_ls.builtins.diagnostics.stylelint,
        null_ls.builtins.diagnostics.yamllint,
        null_ls.builtins.formatting.prettier.with({ filetypes = { "html", "markdown" } }),
        null_ls.builtins.formatting.prettier.with({ filetypes = { "json", "jsonc" }, extra_args = { "--parser=json" } }),
        null_ls.builtins.formatting.stylelint,
      },
    })
  end,
}
