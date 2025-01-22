-- GitHub Copilot (lua) config
require('copilot').setup({
  -- Set enable = true until this bug is fixed:
  -- https://github.com/zbirenbaum/copilot-cmp/issues/10
  suggestion = {
    enabled = true,
    auto_trigger = false,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  panel = { enabled = false },
})

-- User Copilot as a cmp source
-- see completion.lua
require('copilot_cmp').setup()

-- Configure Copilot Chat
local copilot_chat = require('CopilotChat')
copilot_chat.setup({
  window = {
    layout = 'replace',
  }
})

-- Enable cmp completion for Copilot Chat window
require("CopilotChat.integrations.cmp").setup()

-- open copilot chat in the rightmost window
function _G.copilot_chat_right()
  if vim.fn.winnr('$') <= 2 then
    local min_columns = 130
    local width = (vim.o.columns - min_columns) / 2

    if width < 55 then
      width = 55
    end

    vim.api.nvim_command('vert rightbel ' .. width .. ' split')
    copilot_chat.open()
    return
  end

  vim.api.nvim_command('$ wincmd w')
  copilot_chat.open()
end
