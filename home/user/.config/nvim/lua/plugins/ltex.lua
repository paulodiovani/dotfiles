-- This plugin depends on on of these two LSP servers to configured
--   https://github.com/valentjn/ltex-ls
--   https://github.com/ltex-plus/ltex-ls-plus
return {
  "barreiroleo/ltex_extra.nvim",
  branch = "dev",
  dependencies = { "neovim/nvim-lspconfig" },
  -- ft = { "markdown", "tex" },
  event = { "LspAttach *.md", "LspAttach *.tex", "LspAttach *.sty" },

  opts = {
    load_langs = { "en-US", "pt-BR" },
    -- save to .ltex dir
    path = ".ltex",
  },
}
