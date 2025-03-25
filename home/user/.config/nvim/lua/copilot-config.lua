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
copilot_chat.setup({
  chat_autocomplete = false,
  mappings = {
    complete = {
      insert = '<Tab>',
    },
    close = {
      normal = 'q',
      insert = '<noop>',
    },
    show_help = {
      normal = '?',
    },
  },
  window = {
    layout = 'vertical',
    -- width = 0.3,
    width = math.max((vim.o.columns - 130) / 2, vim.o.columns * 0.2),
  },
})
