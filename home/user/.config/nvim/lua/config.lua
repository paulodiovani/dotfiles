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

----------------------
-- INCLUDED CONFIGS --
----------------------
require 'completion'
require 'copilot-config'
require 'copilot-chat-completion'
require 'file-drawer'
