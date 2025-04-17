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
      { "<Leader>gd", ":Gdiffsplit<CR>", desc = "Git diff", silent = true },
      { "<Leader>gb", ":Git blame<CR>", desc = "Git blame", silent = true },
    },
    config = function()
      -- Github integration
      vim.g.github_enterprise_urls = {'[-_\\.a-zA-Z0-9]\\+'}
    end
  },

  -- Github integration
  {
    "tpope/vim-rhubarb",
    cmd = {
      'GBrowse',
    },
  },

  -- Git conflict resolution
  {
    "christoomey/vim-conflicted",
    cmd = {
      'Conflicted',
    },
  }
}
