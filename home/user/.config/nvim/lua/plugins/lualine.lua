return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    { 'franco-ruggeri/codecompanion-lualine.nvim', version = "~0" },
    'nvim-tree/nvim-web-devicons',
  },
  lazy = false,

  opts = {
    options = {
      icons_enabled = true,
      theme = 'base16',
      section_separators = { left = '\u{e0b0}', right = '\u{e0b2}' },
      component_separators = { left = '\u{e0b1}', right = '\u{e0b3}' },
      always_show_tabline = true,
      -- globalstatus = false, -- use laststatus=3 instead
    },

    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        {
          'branch',
          icon = '\u{e0a0} ',
          cond = function()
            local ft = vim.bo.filetype
            return ft ~= 'codecompanion' and ft ~= 'NvimTree'
          end,
        },
        {
          'diff',
          colored = true,
          symbols = {
            added = '+',
            modified = '~',
            removed = '-'
          },
          cond = function()
            local ft = vim.bo.filetype
            return ft ~= 'codecompanion' and ft ~= 'NvimTree'
          end,
        },
      },
      lualine_c = {
        {
          'filename',
          path = 1,
          symbols = {
            modified = '[+]',
            readonly = '[-]',
            unnamed = '[No Name]',
            newfile = '[New]',
          },
        },
      },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress', 'codecompanion' },
      lualine_z = { 'location' },
    },

    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          'filename',
          path = 1,
          symbols = {
            unnamed = '[No Name]',
          },
        },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },

    tabline = {
      lualine_a = {
        {
          'buffers',
          mode = 2,
          show_filename_only = true,
          hide_filename_extension = false,
          shew_modified_status = true,
          symbols = {
            modified = ' [+]',
          },
        },
      },
      lualine_z = {
        {
          'tabs',
          mode = 1,
          cond = function()
            return #vim.api.nvim_list_tabpages() > 1
          end,
        },
      },
    },
  },

  keys = {
    { "gb", function()
      if vim.v.count > 0 then
        require('lualine.components.buffers').buffer_jump(vim.v.count, "!")
      else
        vim.cmd([[buffer #]])
      end
    end, mode = { "n" } },
  }
}
