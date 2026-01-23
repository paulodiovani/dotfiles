---@class DapGutterSymbols
local M = {}

---Setup DAP gutter symbols with ASCII characters and existing highlights
---@return nil
function M.setup()
  -- Define breakpoint signs with ASCII characters and existing highlights
  vim.fn.sign_define('DapBreakpoint', {
    text = '●',
    texthl = 'ErrorMsg',
    numhl = 'ErrorMsg'
  })

  vim.fn.sign_define('DapBreakpointRejected', {
    text = '○',
    texthl = 'ErrorMsg',
    numhl = 'ErrorMsg'
  })

  vim.fn.sign_define('DapBreakpointCondition', {
    text = '◆',
    texthl = 'WarningMsg',
    numhl = 'WarningMsg'
  })

  vim.fn.sign_define('DapLogPoint', {
    text = '●',
    texthl = 'ErrorMsg',
    numhl = 'ErrorMsg'
  })

  vim.fn.sign_define('DapStopped', {
    text = '→',
    texthl = 'Question',
    linehl = 'CursorLine',
    numhl = 'Question'
  })
end

return M
