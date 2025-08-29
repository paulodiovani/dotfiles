-- Utility functions for LSP
local M = {}

-- list workspace folders
function M.list_workspace_folders()
  for _, folder in ipairs(vim.lsp.buf.list_workspace_folders()) do
    print(folder)
  end
end

--- Attempts to run multiple commands until one succeeds
--- @param commands table A list of command arrays to try sequentially
--- @return table Command to be executed with sh -c that chains the commands with || operators
function M.try_commands(commands)
  local cmd = {}
  local count = vim.tbl_count(commands)

  for i, item in ipairs(commands or  {}) do
    vim.list_extend(cmd, item)

    if i < count then
      vim.list_extend(cmd, { '2>', '/dev/null', '||' })
    end
  end

  return { 'sh', '-c', table.concat(cmd, ' ') }
end

return M
