---@class DapEvents
local M = {}

---Setup DAP event listeners for REPL and hover key management
---@return nil
function M.setup()
  local dap = require("dap")
  local dap_ui_widgets = require("dap.ui.widgets")

  -- Auto open/close REPL
  dap.listeners.after.event_initialized["dap_repl"] = function()
    dap.repl.open({ height = math.floor(vim.o.lines * 0.3) })
  end

  dap.listeners.before.event_terminated["dap_repl"] = function()
    dap.repl.close()
  end

  dap.listeners.before.event_exited["dap_repl"] = function()
    dap.repl.close()
  end

  -- Override K key with DAP hover during debug sessions
  dap.listeners.after.event_initialized["dap_hover"] = function()
    vim.keymap.set({ 'n', 'v' }, 'K', dap_ui_widgets.hover, { desc = "DAP Hover" })
  end

  dap.listeners.before.event_terminated["dap_hover"] = function()
    vim.keymap.set({ "n", "v" }, "K", vim.lsp.buf.hover, { desc = "LSP: Hover" })
  end

  dap.listeners.before.event_exited["dap_hover"] = function()
    vim.keymap.set({ "n", "v" }, "K", vim.lsp.buf.hover, { desc = "LSP: Hover" })
  end
end

return M
