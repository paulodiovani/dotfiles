-- LSP configuration
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  event = "VeryLazy",

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

    -- Ruby LSP
    vim.lsp.config("ruby_lsp", {
      cmd = lsp_utils.try_commands({
        { "bundle",  "exec", "ruby-lsp" },
        { "asdf",    "exec", "ruby-lsp" },
        { "ruby-lsp" },
      }),
      init_options = {
        addonSettings = {
          ["Ruby LSP Rails"] = {
            enablePendingMigrationsPrompt = false,
          },
        },
      },
    })

    -- Rubocop
    vim.lsp.config("rubocop", {
      cmd = lsp_utils.try_commands({
        { "bundle",  "exec", "rubocop", "--lsp" },
        { "asdf",    "exec", "rubocop", "--lsp" },
        { "rubocop", "--lsp" },
      }),
    })

    -- Solargraph
    vim.lsp.config("solargraph", {
      cmd = lsp_utils.try_commands({
        { "bundle",     "exec", "solargraph", "stdio" },
        { "asdf",       "exec", "solargraph", "stdio" },
        { "solargraph", "stdio" },
      }),
    })

    -- Sorbet
    vim.lsp.config("sorbet", {
      cmd = lsp_utils.try_commands({
        { "bundle", "exec", "srb",   "tc",                "--lsp", "--disable-watchman" },
        { "asdf",   "exec", "srb",   "tc",                "--lsp", "--disable-watchman" },
        { "srb",    "tc",   "--lsp", "--disable-watchman" },
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

    -- override lsp commands to not open in tab (also in init.vim)
    vim.cmd([[
      command! LspInfo Checkhealth vim.lsp
      command! LspLog lua vim.cmd(string.format('above split %s | setlocal bufhidden=wipe nomodifiable nobuflisted', vim.lsp.get_log_path()))
    ]])
  end,
}
