-- LSP configuration
return {
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = {
    'hrsh7th/nvim-cmp',   -- use cmp for completion
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  },

  config = function()
    -- Set up lspconfig.
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    local lspconfig = require('lspconfig')

    local function config_server(server_name, extra_config)
      local config = {
        capabilities = capabilities,

        on_attach = function(_, bufnr)
          local lsp_utils = require('modules.lsp-utils')

          -- Enable inlay hints by default (should be a config?)
          -- toggle with <Leader><S-8>
          vim.lsp.inlay_hint.enable(true)

          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
          vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')

          -- override lsp commands
          vim.api.nvim_create_user_command('LspInfo', 'Checkhealth vim.lsp', { force = true })
          vim.api.nvim_create_user_command('LspLog',
            function()
              vim.cmd(string.format('above split %s | setlocal bufhidden=wipe nomodifiable nobuflisted',
                vim.lsp.get_log_path()))
            end, { force = true })

          -- default/common lsp mappings
          -- source: `help lsp-defaults

          -- - 'omnifunc' is set to |vim.lsp.omnifunc()|, use |i_CTRL-X_CTRL-O| to trigger
          --   completion.
          -- - 'tagfunc' is set to |vim.lsp.tagfunc()|. This enables features like
          --   go-to-definition, |:tjump|, and keymaps like |CTRL-]|, |CTRL-W_]|,
          --   |CTRL-W_}| to utilize the language server.
          -- - 'formatexpr' is set to |vim.lsp.formatexpr()|, so you can format lines via
          --   |gq| if the language server supports it.
          --   - To opt out of this use |gw| instead of gq, or clear 'formatexpr' on |LspAttach|.
          -- - |K| is mapped to |vim.lsp.buf.hover()| unless |'keywordprg'| is customized or
          --   a custom keymap for `K` exists.
          --
          --                                           *grr* *gra* *grn* *gri* *i_CTRL-S*
          -- Some keymaps are created unconditionally when Nvim starts:
          -- - "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
          -- - "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
          -- - "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
          -- - "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
          -- - "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
          -- - CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()|

          -- custom mappings
          vim.keymap.set('n', 'gD', vim.lsp.buf.definition, { desc = 'LSP: Go to definition' })
          vim.keymap.set('n', 'grt', vim.lsp.buf.type_definition, { desc = 'LSP: Type Definition' })
          vim.keymap.set('n', 'gwa', vim.lsp.buf.add_workspace_folder, { desc = 'LSP: Add Workspace Folder' })
          vim.keymap.set('n', 'gwl', lsp_utils.list_workspace_folders, { desc = 'LSP: List Workspace Folders' })
          vim.keymap.set('n', 'gwr', vim.lsp.buf.remove_workspace_folder, { desc = 'LSP: Remove Workspace Folder' })
          vim.keymap.set({ 'n', 'v' }, '<Leader><F2>', vim.lsp.buf.rename, { desc = 'LSP: Rename' })
        end
      }

      -- merge config with extra configs, where the extra have priority
      config = vim.tbl_deep_extend('force', config, extra_config or {})

      lspconfig[server_name].setup(config)
    end

    -- setup mason
    require('mason').setup()
    require('mason-lspconfig').setup({
      automatic_installation = true,
      ensure_installed = { 'bashls', 'lua_ls', 'vimls' },
      -- Set up server auto setup
      handlers = {
        -- default handler (optional)
        config_server,

        ['jdtls'] = function(server_name)
          config_server(server_name, {
            -- force using asdf shim as java executable
            cmd = {
              'jdtls',
              '--java-executable', vim.fn.expand('$HOME/.asdf/shims/java'),
              '-configuration', vim.fn.expand('$HOME/.cache/jdtls/config'),
              '-data', vim.fn.expand('$HOME/.cache/jdtls/workspace'),
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
        end,

        ['rust_analyzer'] = function(server_name)
          config_server(server_name, {
            settings = {
              ['rust-analyzer'] = {
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
      },
    })
  end,
}
