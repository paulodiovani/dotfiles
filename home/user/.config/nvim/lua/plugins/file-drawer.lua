-- File drawer configuration
return {
  "kyazdani42/nvim-tree.lua",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
    "paulodiovani/vim-darkroom",
  },

  keys = {
    { '<Leader>d', ':DarkRoomLeft DrawerCwd<CR>', silent = true },
    { '<Leader>f', ':DrawerFind<CR>', silent = true },
  },

  cmd = {
    'DrawerCwd',
    'DrawerFind',
  },

  config = function()
    -- nvim-tree and icons config
    require('nvim-web-devicons').setup({
      default = true,
    })

    local nvim_tree = require('nvim-tree')
    local nvim_tree_api = require('nvim-tree.api')

    nvim_tree.setup({
      actions = {
        open_file = {
          resize_window = false,
        },
      },
      diagnostics = {
        enable = false,
      },
      filesystem_watchers = {
        ignore_dirs = {
          "build",
          "dist",
          "node_modules",
          "target",
          "vendor",
        },
      },
      filters = {
        custom = {
          "^\\.git$",       -- git directory
          "^build$",        -- build dir (java, kotlin, etc)
          "^target$",       -- build dir (rust)
          "^\\.classpath$", -- eclipse jdtls
          "^\\.project$",
          "^\\.settings$",
          "^bin\\/.+\\.class$",
          "^Session\\.vim$",  -- vim session
          "^Session\\.lock$", -- vim session
        },
        dotfiles = false,
      },
      git = {
        enable = true,
      },
      view = {
        width = '20%',
        side = 'left',
      },
      experimental = {
        actions = {
          open_file = {
            relative_path = true,
          },
        },
      },
      -- custom mappings
      on_attach = function(bufnr)
        nvim_tree_api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "?", nvim_tree_api.tree.toggle_help,
          { buffer = bufnr, noremap = true, silent = true, nowait = true })
      end,
    })

    vim.api.nvim_create_user_command('DrawerCwd', function()
      nvim_tree_api.tree.open({ current_window = true })
    end, {})

    vim.api.nvim_create_user_command('DrawerFind', function()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.cmd('DarkRoomLeft DrawerCwd')
      nvim_tree_api.tree.find_file { open = false, buf = bufnr, focus = true }
    end, {})
  end,
}
