-- Utility functions for Lua operations
local M = {}

--- Helper function to safely access nested table values
--- @param tbl table The table to access
--- @param ... any Keys to access in nested order
--- @return any|nil The value at the path or nil if path doesn't exist
function M.safe_get(tbl, ...)
  local value = tbl
  for _, key in ipairs({...}) do
    value = value and value[key]
    if value == nil then
      return nil
    end
  end
  return value
end

return M
