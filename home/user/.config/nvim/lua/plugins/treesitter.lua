return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
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
    })
  end,
}
