----------------------
-- SETTINGS SECTION --
----------------------

-- Linter config (nvim-lint)
vim.diagnostic.config({ virtual_text = false })
require('lint').linters_by_ft = {
  javascript = {'eslint'},
  javascriptreact = {'eslint'},
  typescript = {'eslint'},
  typescriptreact = {'eslint'},
  ruby = {'ruby'}
}

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

------------------------------
-- CUSTOM FUNCTIONS SECTION --
------------------------------

vim.g.diagnostics_active = true

function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.hide()
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.show()
  end
end
