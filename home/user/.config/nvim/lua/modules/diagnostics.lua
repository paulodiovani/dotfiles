local utils = require('modules.lua-utils')

-- Diagnostics configuration
vim.diagnostic.config({
  virtual_text = false,
  float = {
    header = false,
    source = true,
    format = function(diagnostic)
      local source = diagnostic.source or 'lsp'
      local href = utils.safe_get(diagnostic, 'user_data', 'lsp', 'codeDescription', 'href')
          or (
            diagnostic.code
            and string.format('https://google.com/search?q=%s+%s', diagnostic.source or '', diagnostic.code)
            or ''
          )
      return string.format('%s\n[%s] %s', diagnostic.message, source, href)
    end,
  },
})

-- Set up diagnostic toggle function
vim.g.diagnostics_active = true

_G.toggle_diagnostics = function()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.hide()
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.show()
  end
end
