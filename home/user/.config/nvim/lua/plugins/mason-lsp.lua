-- Mason config to install/enable LSP
return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  event = "VeryLazy",

  opts = {
    automatic_enable = true, -- default = true
    ensure_installed = { "bashls", "lua_ls", "vimls" },
  },
}
