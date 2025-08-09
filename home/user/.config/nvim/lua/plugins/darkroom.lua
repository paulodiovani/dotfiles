return {
    "paulodiovani/darkroom.nvim",
    dependencies = {
      "folke/edgy.nvim",
      "tinted-theming/tinted-vim",
    },

    -- dev = true, -- use local development version

    opts = {
      left = {
        additional_filetypes = { 'NvimTree' },
      },
      right = {
        additional_filetypes = { 'codecompanion' },
      },
    },

    keys = {
      { '<Leader><BS>', '<Cmd>DarkRoomToggle<CR>', desc = 'Toggle DarkRoom mode' },
    },

    cmd = {
      'DarkRoomLeft',
      'DarkRoomRight',
      'DarkRoomReplaceLeft',
      'DarkRoomReplaceRight',
      'DarkRoomToggle',
    },
  }
