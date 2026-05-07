-- Utility plugins configuration
return {
  -- Comment plugin
  {
    "tomtom/tcomment_vim",
    version = "~4",
    keys = {
      { "<C-_><C-_>", ":TComment<CR>",            mode = "n", desc = "Toggle line comment",      silent = true },
      { "<C-_><C-_>", ":TCommentMaybeInline<CR>", mode = "v", desc = "Toggle multiline comment", silent = true },
      { "<C-_><C-_>", "<C-o>:TComment<CR>",       mode = "i", desc = "Toggle line comment",      silent = true },
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
  {
    "chrisgrieser/nvim-genghis",
    cmd = { "Genghis", "Copy", "Move", "Delete" },
    keys = {
      { "<F2>", function() require("genghis").renameFile() end, desc = "Rename current file" },
    },
    config = function()
      local genghis = require("genghis")
      vim.api.nvim_create_user_command("Copy",
        function() genghis.duplicateFile() end,
        { desc = "Duplicate current file" })
      vim.api.nvim_create_user_command("Move",
        function() genghis.moveAndRenameFile() end,
        { desc = "Move/rename current file" })
      vim.api.nvim_create_user_command("Delete",
        function() genghis.trashFile() end,
        { desc = "Trash current file" })
    end,
  },

  -- Diff lines
  {
    "AndrewRadev/linediff.vim",
    version = "~0",
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
    commit = "29e4b9c",
    cmd = {
      "GenerateMarkdownTOC",
    },
  }
}
