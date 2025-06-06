-- Utility functions for LSP
local M = {}

-- list workspace folders
function M.list_workspace_folders()
  for _, folder in ipairs(vim.lsp.buf.list_workspace_folders()) do
    print(folder)
  end
end

return M
