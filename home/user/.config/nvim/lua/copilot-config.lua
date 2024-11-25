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
require('CopilotChat').setup({
  window = {
    layout = 'replace',
  }
})

-- Enable cmp completion for Copilot Chat window
require("CopilotChat.integrations.cmp").setup()
