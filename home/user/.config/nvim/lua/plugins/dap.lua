return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
    },

    cmd = {
      "DapContinue",
      "DapNew",
      "DapStepOver",
      "DapStepInto",
      "DapStepOut",
      "DapTerminate",
      "DapToggleBreakpoint",
      "DapToggleRepl",
      "DapShowLog",
      "DapRestartFrame",
    },

    keys = {
      { "<Leader><F8>", "<Cmd>DapNew<CR>",              desc = "Start debugging" },
      { "<F8>",         "<Cmd>DapContinue<CR>",         desc = "Continue" },
      { "<F10>",        "<Cmd>DapStepOver<CR>",         desc = "Step over" },
      { "<F11>",        "<Cmd>DapStepInto<CR>",         desc = "Step into" },
      { "<S-F11>",      "<Cmd>DapStepOut<CR>",          desc = "Step out" },
      { "<S-F8>",       "<Cmd>DapTerminate<CR>",        desc = "Stop debug session" },
    },

    build = function()
      local adapter_downloader = require("modules.dap.download-adapter")

      -- Download vscode-js-debug adapter
      adapter_downloader.download_adapter("microsoft/vscode-js-debug", {
        version = "v1.105.0",
        prefix = "js-debug-dap"
      })
    end,

    config = function()
      local dap = require("dap")

      -- Setup virtual text
      require("nvim-dap-virtual-text").setup({})

      -- Setup JavaScript/Node.js adapter
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/dap/js-debug/src/dapDebugServer.js",
          args = { "${port}" },
        },
      }

      -- Default configuration for Node.js
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Node.js Program",
          program = "${workspaceFolder}/index.js",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }

      -- Copy JavaScript configuration to TypeScript
      dap.configurations.typescript = dap.configurations.javascript
    end,
  },
}
