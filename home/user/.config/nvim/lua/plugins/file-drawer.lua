-- File drawer configuration
return {
  "kyazdani42/nvim-tree.lua",
  dependencies = { "kyazdani42/nvim-web-devicons" },

  keys = {
    { '<Leader>d', ':DrawerCwd<CR>',  { silent = true } },
    { '<Leader>f', ':DrawerFind<CR>', { silent = true } },
  },

  cmd = {
    'Drawer',
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

    -- open nvim-tree on the left or leftmost window
    _G.drawer_open = function(path)
      local view = require('nvim-tree.view')
      path = path or vim.fn.getcwd()

      if view.is_visible() then
        nvim_tree_api.tree.focus()
        nvim_tree_api.tree.change_root(path)
        return
      end

      if vim.fn.winnr('$') == 1 then
        nvim_tree_api.tree.open { path }
        return
      end

      vim.api.nvim_command('1 wincmd w')
      nvim_tree_api.tree.open { path, current_window = true }
    end

    _G.drawer_find = function(bufnr)
      local view = require('nvim-tree.view')
      bufnr = bufnr or vim.api.nvim_get_current_buf()

      if not view.is_visible() then
        _G.drawer_open()
      end

      nvim_tree_api.tree.find_file { open = false, buf = bufnr, focus = true }
    end

    -- Define commands
    vim.api.nvim_create_user_command('Drawer', function(opts)
      drawer_open(opts.args ~= "" and opts.args or nil)
    end, { nargs = '?' })

    vim.api.nvim_create_user_command('DrawerCwd', function()
      drawer_open(vim.fn.getcwd())
    end, {})

    vim.api.nvim_create_user_command('DrawerFind', function()
      drawer_find()
    end, {})

    -- ui adjustments
    vim.cmd([[
      " NvimTree overrides
      highlight link NvimTreeNormal WriteRoomNormal
    ]])
  end,
}
