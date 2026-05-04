-- Copilot configuration
return {
  "zbirenbaum/copilot.lua",
  version = "~2",

  opts = {
    -- use system node command
    copilot_node_command = vim.fn.has("macunix") == 1 and vim.fn.systemlist("brew --prefix")[1] .. "/bin/node" or "/usr/bin/node",

    filetypes = {
      ["*"] = true, -- enable for all filetypes
    },

    -- Ghost text disabled: Copilot is surfaced as a blink.cmp source instead.
    suggestion = { enabled = false },
    panel = { enabled = false },
  },

  event = {
    'InsertEnter',
  },

  keys = {
    { '<Leader>cp', '<Cmd>Copilot panel<CR>', mode = { 'n', 'v' }, desc = 'Copilot Panel' },
  },

  cmd = 'Copilot',
}
