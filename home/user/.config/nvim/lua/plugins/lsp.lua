-- LSP configuration
return {
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      'hrsh7th/nvim-cmp', -- use cmp for completion
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

            -- Enable completion triggered by <c-x><c-o>
            vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
            vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')

            -- override lsp commands
            vim.api.nvim_create_user_command('LspInfo', 'Checkhealth vim.lsp', { force = true })
            vim.api.nvim_create_user_command('LspLog',
              function() vim.cmd(string.format('above split %s | setlocal bufhidden=wipe nomodifiable nobuflisted',
                  vim.lsp.get_log_path())) end, { force = true })

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
            vim.keymap.set({ 'n', 'i' }, '<F12>', vim.lsp.buf.definition, { desc = 'LSP: Go to Definition' })
            vim.keymap.set({ 'n', 'i' }, '<F9>', vim.lsp.buf.hover, { desc = 'LSP: Hover' })
            vim.keymap.set({ 'n', 'v' }, '<Leader><F12>', vim.lsp.buf.type_definition, { desc = 'LSP: Type Definition' })
            vim.keymap.set({ 'n', 'v' }, '<Leader><F2>', vim.lsp.buf.rename, { desc = 'LSP: Rename' })
            vim.keymap.set({ 'n', 'v' }, '<Leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: Code Action' })
          end
        }

        for k, v in pairs(extra_config or {}) do
          config[k] = v
        end

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

          -- temporary fix language server root_path when using multi build projects
          -- until this is merged: https://github.com/neovim/nvim-lspconfig/pull/3321
          -- or the issue (https://github.com/fwcd/kotlin-language-server/issues/559) is fixed another way
          ['kotlin_language_server'] = function(server_name)
            local lsp_util = require('lspconfig.util')

            local root_files = {
              'build.gradle',        -- Gradle
              'build.gradle.kts',    -- Gradle
              'settings.gradle',     -- Gradle (multi-project)
              'settings.gradle.kts', -- Gradle (multi-project)
              'pom.xml',             -- Maven
              'build.xml',           -- Ant
            }

            local function root_pattern(...)
              local patterns = lsp_util.tbl_flatten { ... }
              return function(startpath)
                startpath = lsp_util.strip_archive_subpath(startpath)
                local match = lsp_util.search_ancestors(startpath, function(path)
                  for _, pattern in ipairs(patterns) do
                    for _, p in ipairs(vim.fn.glob(lsp_util.path.join(lsp_util.path.escape_wildcards(path), pattern), true, true)) do
                      if lsp_util.path.exists(p) then
                        return path
                      end
                    end
                  end
                end)

                if match ~= nil then
                  return match
                end
              end
            end

            config_server(server_name, {
              root_dir = root_pattern(unpack(root_files)),
            })
          end,

          -- fix java-language-server bad argument error
          -- https://github.com/georgewfraser/java-language-server/issues/267
          ['java_language_server'] = function(server_name)
            config_server(server_name, {
              handlers = {
                ['client/registerCapability'] = function(err, result, ctx, config)
                  local registration = {
                    registrations = { result },
                  }
                  return vim.lsp.handlers['client/registerCapability'](err, registration, ctx, config)
                end,
              },
            })
          end,

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

          ['sorbet'] = function(server_name)
            config_server(server_name, {
              cmd = {
                'srb', 'tc',
                '--lsp',
                '--disable-watchman',
              },
            })
          end,

          ['ts_ls'] = function(server_name)
            config_server(server_name, {
              init_options = {
                hostInfo = "neovim",
                maxTsServerMemory = 8192,
              },
            })
          end,
        },
      })
    end,
  },
}
