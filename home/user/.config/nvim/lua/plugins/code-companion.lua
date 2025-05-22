return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
  },

  opts = {
    -- IS THIS CORRECT?
    send = {
      callback = function(chat)
        vim.cmd("stopinsert")
        chat:submit()
        chat:add_buf_message({ role = "llm", content = "" })
      end,
      index = 1,
      description = "Send",
    },
  },

  keys = {
    {
      '<Leader>cc',
      function()
        vim.cmd('set splitright')
        vim.cmd('DarkRoomReplaceRight CodeCompanionChat')
        vim.cmd('set nosplitright')
      end,
      mode = { 'n', 'v' },
      desc = 'Code Companion right window',
      silent = true
    },
  },

  cmd = {
    'CodeCompanion',
    'CodeCompanionActions',
    'CodeCompanionChat',
    'CodeCompanionCmd',
  },

  config = function(opts)
    require('codecompanion').setup(opts)
    require('modules.codecompanion-spinner'):init()
  end
}
