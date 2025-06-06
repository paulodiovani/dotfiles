-- This plugin depends on on of these two LSP servers to configured
--   https://github.com/valentjn/ltex-ls
--   https://github.com/ltex-plus/ltex-ls-plus
return {
  "barreiroleo/ltex_extra.nvim",
  dependencies = { "neovim/nvim-lspconfig" },

  -- load on save
  event = {
    "BufWritePost *.markdown",
    "BufWritePost *.md",
    "BufWritePost *.tex",
  },

  opts = {
    load_langs = { "en-US", "pt-BR" },
    -- save to .vscode dir for compatibility
    -- https://ltex-plus.github.io/ltex-plus/faq.html#where-does-vscode-ltex-plus-save-its-settings-eg-dictionary-false-positives
    path = ".vscode",
  },
}
