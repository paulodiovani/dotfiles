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
