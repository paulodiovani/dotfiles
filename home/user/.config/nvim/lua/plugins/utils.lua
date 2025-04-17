-- Utility plugins configuration
return {
  -- EditorConfig integration
  { "editorconfig/editorconfig-vim" },

  -- Comment plugin
  { "tomtom/tcomment_vim" },

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

  -- Emmet HTML expansion
  {
    "mattn/emmet-vim",
    filetype = {
      "astro",
      "css",
      "erb",
      "handlebars",
      "hbs",
      "html",
      "javascript",
      "javascriptreact",
      "jsx",
      "less",
      "markdown",
      "php",
      "sass",
      "scss",
      "svelte",
      "tsx",
      "typescript",
      "typescriptreact",
      "vue",
      "xml",
    },
    config = function()
      vim.g.user_emmet_leader_key = '<C-e>'
      vim.g.user_emmet_mode = 'iv'  -- enable only in insert and visual modes
    end
  },

  -- Markdown TOC
  {
    "ajorgensen/vim-markdown-toc",
    cmd = {
      "GenerateMarkdownTOC",
    },
  }
}
