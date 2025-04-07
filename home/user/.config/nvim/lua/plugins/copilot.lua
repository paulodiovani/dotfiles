-- Copilot configuration
return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = { "zbirenbaum/copilot-cmp" },
    config = function()
      -- GitHub Copilot (lua) config
      require('copilot').setup({
        copilot_model = 'claude-3.7-sonnet',
        -- Set enable = true until this bug is fixed:
        -- https://github.com/zbirenbaum/copilot-cmp/issues/10
        suggestion = {
          enabled = true,
          auto_trigger = false,
          debounce = 75,
          keymap = {
            accept = '<M-l>',
            accept_word = false,
            accept_line = false,
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
        panel = { enabled = false },
      })

      -- User Copilot as a cmp source
      require('copilot_cmp').setup()
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "zbirenbaum/copilot.lua",
    },
    config = function()
      -- Configure Copilot Chat
      local copilot_chat = require('CopilotChat')
      copilot_chat.setup({
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
      })

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

      -- Key mappings
      vim.keymap.set('n', '<Leader>cp', ':Copilot panel<CR>>', { silent = true })
      vim.keymap.set('n', '<Leader>cc', ':CopilotChatRight<CR>', { silent = true })
    end,
  }
}
