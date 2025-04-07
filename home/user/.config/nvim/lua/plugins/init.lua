-- Main plugin configuration
return {
  -- Core plugins with custom configs
  { import = "plugins.colorscheme" },  -- Color theme
  { import = "plugins.treesitter" },   -- Syntax highlighting
  { import = "plugins.completion" },   -- LSP and completion
  { import = "plugins.null-ls" },      -- Additional diagnostics
  { import = "plugins.copilot" },      -- GitHub Copilot integration
  { import = "plugins.file-drawer" },  -- File explorer
  { import = "plugins.fzf" },          -- Fuzzy finder
  { import = "plugins.lightline" },    -- Status line
  { import = "plugins.vim-test" },     -- Testing integration
  { import = "plugins.ui" },           -- UI plugins (indentLine, etc)
  { import = "plugins.git" },          -- Git integration
  { import = "plugins.utils" },        -- Utility plugins

  -- Core dependency
  { "nvim-lua/plenary.nvim" },
}
