-- luacheck: ignore vim

----------------------
-- SETTINGS SECTION --
----------------------

-- diagnostics config
vim.diagnostic.config({
  virtual_text = false,
})

-- treesitter config
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'javascript',
    'json',
    'markdown',
    'ruby',
    'scss',
    'tsx',
    'typescript',
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
nvim_tree.setup({
  disable_netrw = true,
  actions = {
    open_file = {
      resize_window = false,
      -- window_picker = {
      --   enable = false,
      -- },
    },
  },
  filters = {
    custom = {
      '^\\.git'
    }
  },
  view = {
    width = '20%',
    side = 'left',
  },
})

-- LSP config
local lspconfig = require('lspconfig')
lspconfig.bashls.setup {}
lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  }
}
lspconfig.solargraph.setup {}
lspconfig.tsserver.setup {}
lspconfig.vimls.setup {}

-- Linters and other stuff (null-ls)
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    -- diagnostics
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.diagnostics.luacheck,
    null_ls.builtins.diagnostics.rubocop,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.stylelint,
    null_ls.builtins.diagnostics.yamllint,
    -- formatting
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.formatting.json_tool.with({
      extra_args = { '--indent=2' },
    }),
    -- null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.rubocop,
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

-- open nvim-tree in current buffer
local function drawer_in_place(path)
  local core = require('nvim-tree.core')
  local view = require('nvim-tree.view')
  local renderer = require('nvim-tree.renderer')

  core.init(path)
  view.open_in_current_win { hijack_current_buf = false, resize = false }
  renderer.draw()
end

-- open nvim-tree on the left or leftmost window
function _G.drawer_open(path)
  local view = require('nvim-tree.view')
  path = path or vim.fn.getcwd()

  if view.is_visible() then
    nvim_tree.focus()
    nvim_tree.change_dir(path)
    return
  end

  if vim.fn.winnr('$') == 1 then
    nvim_tree.open(path)
    return
  end

  vim.api.nvim_command('1 wincmd w')
  drawer_in_place(path)
end

function _G.drawer_find(bufnr)
  local view = require('nvim-tree.view')
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if not view.is_visible() then
    _G.drawer_open()
  end

  nvim_tree.find_file(false, bufnr, false)
  nvim_tree.focus()
end
