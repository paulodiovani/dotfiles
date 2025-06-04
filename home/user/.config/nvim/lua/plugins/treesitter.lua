return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",

  opts = {
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,
    ensure_installed = {
      "bash",
      "json",
      "lua",
      "luadoc",
      "markdown",
      "vim",
      "vimdoc",
    },
    highlight = {
      enable = true,
    },
  },
}
