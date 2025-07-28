-- LSP configuration
return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },

  config = function()
    -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lsp_utils = require("modules.lsp-utils")
    local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- custom mappings (also check fzf.lua)
    -- vim.keymap.set("n", "gD", vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
    -- vim.keymap.set("n", "grt", vim.lsp.buf.type_definition, { desc = "LSP: Type Definition" })
    vim.keymap.set("n", "gwa", vim.lsp.buf.add_workspace_folder, { desc = "LSP: Add Workspace Folder" })
    vim.keymap.set("n", "gwl", lsp_utils.list_workspace_folders, { desc = "LSP: List Workspace Folders" })
    vim.keymap.set("n", "gwr", vim.lsp.buf.remove_workspace_folder, { desc = "LSP: Remove Workspace Folder" })
    vim.keymap.set({ "n", "v" }, "<Leader><F2>", vim.lsp.buf.rename, { desc = "LSP: Rename" })
    -- make K always open LSP Hover and not keywordprg
    vim.keymap.set({ "n", "v" }, "K", vim.lsp.buf.hover, { desc = "LSP: Hover" })

    -- All servers
    vim.lsp.config('*', {
      capabilities = cmp_capabilities,
    })

    -- Java JDTLS
    vim.lsp.config("jdtls", {
      -- capabilities = capabilities,
      -- on_attach = lsp_utils.on_attach,

      -- force using asdf shim as java executable
      cmd = {
        "jdtls",
        "--java-executable", vim.fn.expand("$HOME/.asdf/shims/java"),
        "-configuration", vim.fn.expand("$HOME/.cache/jdtls/config"),
        "-data", vim.fn.expand("$HOME/.cache/jdtls/workspace"),
      },

      settings = {
        java = {
          autobuild = {
            enabled = false,
          },

          gradle = {
            buildServer = {
              enabled = true,
            },
          },
        },
      },
    })

    -- Ltex LSP + ltex_extra
    vim.lsp.config("ltex_plus", {
      settings = {
        ltex = {
          checkFrequency = 'save',
          enabled = { 'markdown', 'plaintex', 'rst', 'tex', 'latex' },
          language = 'en-US', -- default language
        },
      },
    })

    -- Solargraph
    vim.lsp.config("solargraph", {
      cmd = lsp_utils.check_executable({
        { cmd = { "bundle", "exec", "solargraph", "stdio" }, check = "bundle exec solargraph --version" },
        { cmd = { "asdf", "exec", "solargraph", "stdio" },   check = "asdf exec solargraph --version" },
        { cmd = { "solargraph", "stdio" },                   check = "solargraph --version" },
      }),
    })

    -- Rust Analyzer config
    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            buildScripts = {
              enable = true,
            },
            loadOutDirsFromCheck = true,
            procMacro = {
              enable = true,
            },
          },
        },
      },
    })
  end,
}
