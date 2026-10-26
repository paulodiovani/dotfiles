-- Neovim 0.12+ has built-in treesitter support, no external plugin needed.
-- For additional parsers: install tree-sitter-cli and run :TSInstall <lang>
return {
  {
    -- Dummy spec to run treesitter setup code without installing a plugin
    "nvim-treesitter/nvim-treesitter",
    enabled = false,
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
  },
}
