-- Copilot Chat configuration
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "zbirenbaum/copilot.lua",
      "paulodiovani/vim-darkroom",
    },

    opts = {
      -- model = 'claude-3.7-sonnet',
      chat_autocomplete = false,
      mappings = {
        complete = {
          insert = '<Tab>',
        },
        close = {
          normal = 'q',
          insert = '',
        },
        show_help = {
          normal = '?',
        },
      },
      window = {
        layout = 'replace',
      },
    },

    keys = {
      { '<Leader>cc', '<Cmd>DarkRoomRight CopilotChatOpen<CR>', mode = { 'n', 'v' }, desc = 'Copilot Chat right window', silent = true },
    },

    cmd = {
      'CopilotChat',
      'CopilotChatOpen',
      'CopilotChatClose',
      'CopilotChatToggle',
    },

    config = function(_, opts)
      -- Configure Copilot Chat
      local copilot_chat = require('CopilotChat')
      copilot_chat.setup(opts)

      -- Add chat completion
      require('modules.copilot-chat-completion')
    end,
  }
}
