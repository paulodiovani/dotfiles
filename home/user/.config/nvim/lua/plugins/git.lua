-- Git-related plugins configuration
return {
  -- Fugitive (Git integration)
  {
    "tpope/vim-fugitive",
    config = function()
      -- Key mappings
      vim.keymap.set('n', '<Leader>gd', ':Gdiffsplit<CR>', { silent = true })
      vim.keymap.set('n', '<Leader>gb', ':Git blame<CR>', { silent = true })

      -- Github integration
      vim.g.github_enterprise_urls = {'[-_\\.a-zA-Z0-9]\\+'}
    end
  },

  -- Github integration
  { "tpope/vim-rhubarb" },

  -- Git conflict resolution
  { "christoomey/vim-conflicted" }
}
