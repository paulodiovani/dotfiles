-- Utility plugins configuration
return {
  -- EditorConfig integration
  { "editorconfig/editorconfig-vim" },

  -- Comment plugin
  { "tomtom/tcomment_vim",
    keys = {
      { "<C-_><C-_>", ":TComment<CR>", mode = "n", desc = "Toggle line comment", silent = true },
      { "<C-_><C-_>", ":TCommentMaybeInline<CR>", mode = "v", desc = "Toggle multiline comment", silent = true },
      { "<C-_><C-_>", "<C-o>:TComment<CR>", mode = "i", desc = "Toggle line comment", silent = true },
    },
    cmd = {
      "TComment",
    },
    init = function()
      vim.cmd([[
        " Disable maps
        let g:tcomment_maps = 0
      ]])
    end,
  },

  -- File operations
  { "tpope/vim-eunuch" },

  -- Diff lines
  {
    "AndrewRadev/linediff.vim",
    cmd = {
      "Linediff",
      "LinediffAdd",
      "LinediffLast",
      "LinediffPick",
      "LinediffShow",
      "LinediffMerge",
      "LinediffReset",
    },
  },

  -- Markdown TOC
  {
    "ajorgensen/vim-markdown-toc",
    cmd = {
      "GenerateMarkdownTOC",
    },
  }
}
