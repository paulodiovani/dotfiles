-- Utility plugins configuration
return {
  -- EditorConfig integration
  { "editorconfig/editorconfig-vim" },

  -- Comment plugin
  { "tomtom/tcomment_vim" },

  -- File operations
  { "tpope/vim-eunuch" },

  -- Diff lines
  { "AndrewRadev/linediff.vim" },

  -- Emmet HTML expansion
  {
    "mattn/emmet-vim",
    config = function()
      vim.g.user_emmet_leader_key = '<C-e>'
      vim.g.user_emmet_mode = 'iv'  -- enable only in insert and visual modes
    end
  },

  -- Markdown TOC
  { "ajorgensen/vim-markdown-toc" }
}
