return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'base16',
        section_separators = { left = '\u{e0b0}', right = '\u{e0b2}' },
        component_separators = { left = '\u{e0b1}', right = '\u{e0b3}' },
        always_show_tabline = true,
        globalstatus = true,
      },

      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          {
            'branch',
            icon = '\u{e0a0} ',
            cond = function()
              return vim.fn.exists('*FugitiveHead') == 1 and vim.fn.FugitiveHead() ~= ''
            end,
          },
          {
            function()
              if vim.bo.readonly and vim.bo.filetype ~= 'help' then
                return '\u{e0a2}'
              end
              return ''
            end,
            cond = function()
              return vim.bo.filetype ~= 'help' and vim.bo.readonly
            end,
          },
          {
            function()
              if vim.fn.exists('*ConflictedVersion') == 1 then
                local v = vim.fn.ConflictedVersion()
                if v ~= '' then
                  return '\u{22b6} ' .. v
                end
              end
              return ''
            end,
            cond = function()
              return vim.fn.exists('*ConflictedVersion') == 1 and vim.fn.ConflictedVersion() ~= ''
            end,
          },
          {
            'diff',
            colored = true,
            symbols = { added = '+', modified = '~', removed = '-' },
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
        lualine_y = { 'progress' },
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
            mode = 4,
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
          },
        },
      },
    }
  end
}
