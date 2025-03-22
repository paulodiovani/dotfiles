-- GitHub Copilot (lua) config
require('copilot').setup({
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
-- see completion.lua
require('copilot_cmp').setup()

-- Configure Copilot Chat
local copilot_chat = require('CopilotChat')
local select = require('CopilotChat.select')
copilot_chat.setup({
  chat_autocomplete = true,
  context = { 'buffers:listed' },
  selection = function(source)
    return select.visual(source) or select.buffer(source)
  end,
  window = {
    layout = 'replace',
  },
})
