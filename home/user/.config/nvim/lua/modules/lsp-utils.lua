-- Utility functions for LSP
local M = {}

-- signature help function
function M.signature_help()
  local close_events = { 'CursorMoved', 'InsertEnter', 'InsertLeave', 'BufLeave', 'BufWinLeave', 'WinScrolled' }
  vim.lsp.buf.signature_help({ close_events = close_events, focusable = false })
end

-- list workspace folders
function M.list_workspace_folders()
  for _, folder in ipairs(vim.lsp.buf.list_workspace_folders()) do
    print(folder)
  end
end

return M
