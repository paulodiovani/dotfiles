-- Git-related plugins configuration
return {
  -- Fugitive (Git integration)
  {
    "tpope/vim-fugitive",
    lazy = false, -- always load fugitive
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<Leader>gd", ":DarkRoomReplaceLeft Gdiffsplit<CR>", desc = "Git diff", silent = true },
      { "<Leader>gdh", ":DarkRoomReplaceLeft Gdiffsplit HEAD<CR>", desc = "Git diff HEAD", silent = true },
      { "<Leader>gdm", ":DarkRoomReplaceLeft Gdiffsplit main<CR>", desc = "Git diff main", silent = true },
      { "<Leader>gb", ":Git blame<CR>", desc = "Git blame", silent = true },
    },
  },

  -- Github integration
  {
    "tpope/vim-rhubarb",
    lazy = false, -- always load rhubarb
    dependencies = {
      "tpope/vim-fugitive",
    },
    init = function()
      -- Github integration
      vim.g.github_enterprise_urls = {'[-_\\.a-zA-Z0-9]\\+'}
    end,
  },

  -- Git conflict resolution
  {
    -- "christoomey/vim-conflicted",
    "paulodiovani/vim-conflicted",
    branch = "fix/hide-non-vim-error",
    dependencies = {
      "tpope/vim-fugitive",
    },
    cmd = {
      'Conflicted',
    },
  }
}
