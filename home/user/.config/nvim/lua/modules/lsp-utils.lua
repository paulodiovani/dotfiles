-- Utility functions for LSP
local M = {}

-- list workspace folders
function M.list_workspace_folders()
  for _, folder in ipairs(vim.lsp.buf.list_workspace_folders()) do
    print(folder)
  end
end

---Finds the first executable command from a list of commands
---@param commands table[] List of command objects, each with 'cmd' and 'check' properties
---@return string First working command or fallback command
---
---Example:
---```lua
---local cmd = M.first_executable({
---  { cmd = "prettier", check = "command -v prettier" },
---  { cmd = "prettierd", check = "command -v prettierd" }
---})
---```
function M.check_executable(commands)
  local cmd = 'exit 1'

  for _, item in ipairs(commands or  {}) do
    cmd = item["cmd"]
    local check = item["check"]

    if os.execute(check .. ' &> /dev/null') == 0 then
      return cmd
    end
  end

  return cmd -- fallback to last command
end

return M
