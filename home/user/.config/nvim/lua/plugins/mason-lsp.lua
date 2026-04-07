-- Mason config to install/enable LSP
return {
  "mason-org/mason-lspconfig.nvim",
  version = "~2",
  dependencies = {
    { "mason-org/mason.nvim", version = "~2", opts = {} },
    { "neovim/nvim-lspconfig", version = "~2" },
  },
  event = "VeryLazy",

  opts = {
    automatic_enable = true, -- default = true
    ensure_installed = { "bashls", "lua_ls", "vimls" },
  },
}
