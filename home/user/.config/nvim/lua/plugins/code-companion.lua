return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
  },

  opts = {
    display = {
      chat = {
        show_header_separator = true,
        show_settings = true,
        window = {
          layout = 'vertical',
          position = 'right',
          width = 0.3,
        },
      },
    },
    send = {
      callback = function(chat)
        -- https://github.com/olimorris/codecompanion.nvim/discussions/640#discussioncomment-12866279
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
      '<Cmd>DarkRoomReplaceRight CodeCompanionChat<CR>',
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

  config = function(_, opts)
    require('codecompanion').setup(opts)
    require('modules.codecompanion-spinner'):init()
  end
}
