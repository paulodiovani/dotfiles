-- UI-related plugins configuration
return {
  -- IndentLine configuration
  {
    "Yggdroot/indentLine",
    config = function()
      vim.g.indentLine_char = '▏'
      -- vim.g.indentLine_conceallevel = 0
      -- vim.g.indentLine_fileTypeExclude = {'markdown'}

      -- Toggle mapping (from init.vim)
      vim.keymap.set('n', '<Leader>!', ':IndentLinesToggle<CR>', { silent = true })
    end
  },

  -- InterestingWords configuration
  {
    "lfv89/vim-interestingwords",
    config = function()
      vim.g.interestingWordsGUIColors = {
        '#800000', '#008000', '#808000', '#000080', '#800080', '#008080',
        '#c0c0c0', '#808080', '#ff0000', '#00ff00', '#ffff00', '#0000ff'
      }
      vim.g.interestingWordsTermColors = {
        '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'
      }
      vim.g.interestingWordsRandomiseColors = 1
    end
  },

  -- Signature marks
  {
    "kshenoy/vim-signature",
    config = function()
      -- Toggle mapping (from init.vim)
      vim.keymap.set('n', '<Leader>@', ':SignatureToggle<CR>', { silent = true })
    end,
  },

  -- DarkRoom plugin
  {
    "paulodiovani/darkroom.nvim",
    dependencies = {
      "folke/edgy.nvim",
      "tinted-theming/tinted-vim",
    },

    dev = true, -- use local development version

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

    init = function()
      vim.cmd([[
        " hide split separator
        " TODO: make part of plugin
        "highlight WinSeparator ctermfg=bg ctermbg=NONE guifg=bg guibg=NONE
        set fillchars+=vert:\ " hide vertical window separator
      ]])
    end,
  },
}
