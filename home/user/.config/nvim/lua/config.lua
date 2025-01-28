-- luacheck: globals vim
require('lua-utils')

----------------------
-- SETTINGS SECTION --
----------------------

-- diagnostics config
vim.diagnostic.config({
  virtual_text = false,
  float = {
    header = false,
    border = 'rounded',
    source = true,
    format = function(diagnostic)
      local source = diagnostic.source or 'lsp'
      local href = safe_get(diagnostic, 'user_data', 'lsp', 'codeDescription', 'href')
        or (
          diagnostic.code
            and string.format('https://google.com/search?q=%s+%s', diagnostic.source or '', diagnostic.code)
          or ''
        )
      return string.format('%s\n[%s] %s', diagnostic.message, source, href)
    end,
  },
})

-- treesitter config
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'json',
    'lua',
    'luadoc',
    'markdown',
    'vim',
    'vimdoc',
  },
  highlight = {
    enable = true,
  },
})

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
      '^\\.git$'
    },
    dotfiles = true,
  },
  git = {
    enable = false,
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

-- Linters and other stuff (null-ls)
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    -- diagnostics
    null_ls.builtins.diagnostics.codespell,
    null_ls.builtins.diagnostics.erb_lint,
    null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.diagnostics.yamllint,
    -- formatting
    null_ls.builtins.formatting.prettier.with({ filetypes = { 'html', 'markdown' } }),
    null_ls.builtins.formatting.prettier.with({ filetypes = { 'json', 'jsonc' }, extra_args = { '--parser=json' } }),
    null_ls.builtins.formatting.erb_format,
    null_ls.builtins.formatting.stylelint,
  },
})

------------------------------
-- CUSTOM FUNCTIONS SECTION --
------------------------------

vim.g.diagnostics_active = true

-- toggle diagnostics
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.hide()
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.show()
  end
end

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

----------------------
-- INCLUDED CONFIGS --
----------------------
require 'completion'
require 'copilot-config'
