-- Copilot Chat configuration
return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "zbirenbaum/copilot.lua",
    },

    opts = {
      model = 'claude-3.7-sonnet',
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
      { '<Leader>cc', '<Cmd>CopilotChatRight<CR>', mode = { 'n', 'v' }, desc = 'Copilot Chat right window' },
    },

    cmd = {
      'CopilotChat',
      'CopilotChatRight',
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

      -- Replace the rightmost window with copilot-chat, if any
      vim.api.nvim_create_user_command('CopilotChatRight', function()
        local ccname = 'copilot-chat'
        local ccwins = #vim.tbl_filter(function(win)
          local buf = vim.api.nvim_win_get_buf(win)
          return vim.api.nvim_buf_get_name(buf) == ccname
        end, vim.api.nvim_list_wins())

        if ccwins == 0 then
          if #vim.api.nvim_list_wins() > 2 then
            vim.cmd('$ wincmd w')
          else
            local cols = vim.o.columns
            vim.cmd('vert ' .. math.floor(cols * 0.25) .. ' split')
          end
        end

        vim.cmd('CopilotChatOpen')
      end, { range = true })

      -- ui adjustments
      vim.cmd([[
        " copilot chat theme overrides
        highlight! link CopilotChatNormal WriteRoomNormal
        autocmd BufEnter copilot-chat setlocal winhighlight=Normal:CopilotChatNormal
        autocmd BufEnter copilot-chat setlocal nocursorline
      ]])
    end,
  }
}
