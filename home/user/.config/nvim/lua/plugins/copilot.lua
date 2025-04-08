-- Copilot configuration
return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "zbirenbaum/copilot-cmp",
    },

    opts = {
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
    },

    event = {
      'InsertEnter',
    },

    keys = {
      { '<Leader>cp', '<Cmd>Copilot panel<CR>', mode = { 'n', 'v' }, desc = 'Copilot Panel' },
    },

    cmd = 'Copilot',

    config = function(_, opts)
      require('copilot').setup(opts)

      -- Use Copilot as a cmp source
      require('copilot_cmp').setup()
    end,
  },
}
