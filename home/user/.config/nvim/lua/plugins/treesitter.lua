return {
  "nvim-treesitter/nvim-treesitter",
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
      "markdown_inline",
      "vim",
      "vimdoc",
    },
    highlight = {
      enable = true,
    },
  },

  init = function()
    -- enable treesitter highlight and fold for current filetype
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { '*' },
      callback = function(ev)
        if vim.treesitter.get_parser(ev.buf, nil, { error = false }) then
          vim.treesitter.start(ev.buf)
          vim.wo[0][0].foldmethod = 'expr'
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        end
      end,
    })
  end,

  config = function(_, opts)
    require("nvim-treesitter").setup(opts)

    vim.treesitter.language.register("markdown", { "codecompanion" })
  end,
}
