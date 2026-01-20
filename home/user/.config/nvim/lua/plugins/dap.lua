return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "theHamsta/nvim-dap-virtual-text",
  },

  cmd = {
    "DapClearBreakpoints",
    "DapContinue",
    "DapNew",
    "DapShowLog",
    "DapStepInto",
    "DapStepOut",
    "DapStepOver",
    "DapTerminate",
    "DapToggleBreakpoint",
    "DapToggleRepl",
  },

  keys = {
    {
      "<Leader><F8>",
      function()
        local dap = require("dap")
        if dap.session() then
          dap.terminate()
        else
          dap.continue()
        end
      end,
      desc = "Start debugging/Terminate"
    },
    { "<F8>",    "<Cmd>DapContinue<CR>",         desc = "Continue" },
    { "<F9>",    "<Cmd>DapToggleBreakpoint<CR>", desc = "Toggle breakpoint" },
    { "<F10>",   "<Cmd>DapStepOver<CR>",         desc = "Step over" },
    { "<F11>",   "<Cmd>DapStepInto<CR>",         desc = "Step into" },
    { "<S-F11>", "<Cmd>DapStepOut<CR>",          desc = "Step out" },
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

    -- Auto open/close REPL
    dap.listeners.after.event_initialized["dap_repl"] = function()
      dap.repl.open()
    end

    dap.listeners.before.event_terminated["dap_repl"] = function()
      dap.repl.close()
    end

    dap.listeners.before.event_exited["dap_repl"] = function()
      dap.repl.close()
    end

    -- Setup JavaScript/Node.js adapter
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { vim.fn.stdpath("data") .. "/dap/js-debug/src/dapDebugServer.js", "${port}" },
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
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach to Remote",
        address = function()
          return vim.fn.input("Remote address (default localhost): ", "localhost")
        end,
        port = function()
          return tonumber(vim.fn.input("Remote port (default 9229): ", "9229"))
        end,
        localRoot = "${workspaceFolder}",
        remoteRoot = function()
          return vim.fn.input("Remote root path: ", "/app")
        end,
        sourceMaps = true,
        restart = true,
      },
    }

    -- Copy JavaScript configuration to TypeScript
    dap.configurations.typescript = dap.configurations.javascript

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

    vim.fn.sign_define('DapStopped', {
      text = '→',
      texthl = 'Question',
      linehl = 'CursorLine',
      numhl = 'Question'
    })
  end,
}
