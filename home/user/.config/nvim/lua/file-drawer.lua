----------------------
-- SETTINGS SECTION --
----------------------

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
      -- window_picker = {
      --   enable = false,
      -- },
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
      '^\\.git$',             -- git directory
      '^build$',              -- build dir (java, kotlin, etc)
      '^target$',             -- build dir (rust)
      '^\\.classpath$',       -- eclipse jdtls
      '^\\.project$',
      '^\\.settings$',
      '^bin\\/.+\\.class$',
      '^Session\\.vim$', -- vim session
      '^Session\\.lock$', -- vim session
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
    vim.keymap.set("n", "?", nvim_tree_api.tree.toggle_help, { buffer = bufnr, noremap = true, silent = true, nowait = true })
  end,
})

------------------------------
-- CUSTOM FUNCTIONS SECTION --
------------------------------

-- open nvim-tree on the left or leftmost window
function _G.drawer_open(path)
  local view = require('nvim-tree.view')
  path = path or vim.fn.getcwd()

  if view.is_visible() then
    nvim_tree_api.tree.focus()
    nvim_tree_api.tree.change_dir { path }
    return
  end

  if vim.fn.winnr('$') == 1 then
    nvim_tree_api.tree.open { path }
    return
  end

  vim.api.nvim_command('1 wincmd w')
  nvim_tree_api.tree.open { path, current_window = true }
end

function _G.drawer_find(bufnr)
  local view = require('nvim-tree.view')
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if not view.is_visible() then
    _G.drawer_open()
  end

  nvim_tree_api.tree.find_file { open = false, buf = bufnr, focus = true }
end

