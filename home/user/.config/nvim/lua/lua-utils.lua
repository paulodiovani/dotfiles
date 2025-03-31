-- Helper function to safely access nested table values
function safe_get(tbl, ...)
  local value = tbl
  for _, key in ipairs({...}) do
    value = value and value[key]
    if value == nil then
      return nil
    end
  end
  return value
end
