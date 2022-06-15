----------------------
-- SETTINGS SECTION --
----------------------

-- Linter config (nvim-lint)
vim.diagnostic.config({ virtual_text = false })
require('lint').linters_by_ft = {
  json = {'prettier'},
  javascript = {'eslint'},
  typescript = {'eslint'},
  ruby = {'ruby'}
}

-- LSP config
require('nvim-lsp-installer').setup {}

local lspconfig = require('lspconfig')
lspconfig.bashls.setup {}
lspconfig.html.setup {}
lspconfig.sumneko_lua.setup {}
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
