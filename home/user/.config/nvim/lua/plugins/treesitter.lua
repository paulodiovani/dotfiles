-- Neovim 0.12+ has built-in treesitter support.
-- nvim-treesitter (main branch) installs parsers and queries: :TSInstall <lang>
-- Requires tree-sitter-cli.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    init = function()
      -- Enable treesitter highlight and fold for current filetype
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { '*' },
        callback = function(ev)
          if vim.treesitter.get_parser(ev.buf, nil, { error = false }) then
            vim.treesitter.start(ev.buf)
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          end
        end,
      })

      -- Register markdown parser for codecompanion buffers
      vim.treesitter.language.register("markdown", { "codecompanion" })
    end,

    config = function()
      local treesitter = require("nvim-treesitter")

      -- Install most used parsers
      treesitter.install({
        "bash",
        "diff",
        "git_rebase",
        "gitcommit",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
      })
    end,
  },
}
