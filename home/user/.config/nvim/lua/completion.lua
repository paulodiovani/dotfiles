-- luacheck: globals vim
local util = vim.lsp.util
local get_clients = vim.lsp.get_clients or vim.lsp.get_active_clients

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local servers = { 'bashls', 'lua_ls', 'vimls' }

local function config_server(server_name, extra_config)
  local config = {
    capabilities = capabilities,

    on_attach = function(_, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set({ 'n', 'i' }, '<Leader><F2>', vim.lsp.buf.rename, bufopts)
      vim.keymap.set({ 'n', 'i' }, '<F12>', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', '<Leader><F12>', vim.lsp.buf.type_definition, bufopts)

      -- default: K
      vim.keymap.set({ 'n' }, 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, bufopts)
      vim.keymap.set({ 'n', 'i' }, '<F9>', function() vim.lsp.buf.hover({ border = 'rounded' }) end, bufopts)

      local close_events = { "CursorMoved", "InsertEnter", "InsertLeave", "BufLeave", "BufWinLeave", "WinScrolled" }
      vim.keymap.set({ 'i' }, '<C-k>', function()
        vim.lsp.buf.signature_help({ border = 'rounded', close_events = close_events, focusable = false })
      end, bufopts)

      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)

      -- override lsp commands
      vim.api.nvim_create_user_command('LspInfo', 'Checkhealth lspconfig', { force = true })
      vim.api.nvim_create_user_command('LspLog', function() vim.cmd(string.format('above split %s | setlocal bufhidden=wipe nomodifiable nobuflisted', vim.lsp.get_log_path())) end, { force = true })
    end
  }

  for k, v in pairs(extra_config or {}) do
    config[k] = v
  end

  lspconfig[server_name].setup(config)
end

-- setup global installed servers
-- config_server('solargraph')
-- config_server('rust_analyzer')

-- setup mason
require('mason').setup()
require('mason-lspconfig').setup({
  automatically_installation = true,
  ensure_installed = servers,
  -- Set up server auto setup
  handlers = {
    -- default handler (optional)
    config_server,

    -- temporary fix language server root_path when using multi build projects
    -- until this is merged: https://github.com/neovim/nvim-lspconfig/pull/3321
    -- or the issue (https://github.com/fwcd/kotlin-language-server/issues/559) is fixed another way
    ['kotlin_language_server'] = function()
      local lsp_util = require('lspconfig.util')

      local root_files = {
        'build.gradle', -- Gradle
        'build.gradle.kts', -- Gradle
        'settings.gradle', -- Gradle (multi-project)
        'settings.gradle.kts', -- Gradle (multi-project)
        'pom.xml', -- Maven
        'build.xml', -- Ant
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

      config_server('kotlin_language_server', {
        root_dir = root_pattern(unpack(root_files)),
      })
    end,

    -- fix java-language-server bad argument error
    -- https://github.com/georgewfraser/java-language-server/issues/267
    ['java_language_server'] = function()
      config_server('java_language_server', {
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

    ['jdtls'] = function()
      config_server('jdtls', {
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

    ['rust_analyzer'] = function()
      config_server('rust_analyzer', {
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

    ['sorbet'] = function()
      config_server('sorbet', {
        cmd = {
          'srb', 'tc',
          '--lsp',
          '--disable-watchman',
        },
      })
    end,

    ['ts_ls'] = function()
      config_server('ts_ls', {
        init_options = {
          hostInfo = "neovim",
          maxTsServerMemory = 8192,
        },
      })
    end,
  },
})

-- Set up luasnip
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()

local has_words_before = function()
  -- luacheck: globals unpack
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Set up nvim-cmp.
local cmp = require('cmp')
local lspkind = require('lspkind')

-- avoid copiloting injecting completions at first position
-- https://github.com/zbirenbaum/copilot-cmp/issues/88#issuecomment-1960619171
local copilot_reverse_prioritize = function(entry1, entry2)
  if entry1.source.name == 'copilot' and entry2.source.name ~= 'copilot' then
    return false
  elseif entry2.copilot == 'copilot' and entry1.source.name ~= 'copilot' then
    return true
  end
end

---@cast cmp -nil
cmp.setup({
  completion = {
    autocomplete = false,
    completeopt = table.concat(vim.opt.completeopt:get(), ","),
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
        -- they way you will only jump inside the snippet region
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
        -- elseif has_words_before() then
        --   cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    { name = 'copilot' },
  }, {
    { name = 'copilot' },
    { name = 'buffer' },
  }),

  sorting = {
    comparators = {
      copilot_reverse_prioritize,
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      -- cmp.config.compare.scopes,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      -- cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    }
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      -- mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
      menu = {
        buffer = '[Buffer]',
        nvim_lsp = '[LSP]',
        luasnip = '[LuaSnip]',
        nvim_lua = '[Lua]',
        latex_symbols = '[Latex]',
        copilot = '[Copilot]',
      },
      symbol_map = {
        Copilot = '',
      },
    })
  }
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
--     { name = 'git' },
--   }, {
--     { name = 'buffer' },
--   })
-- })

local cmdlineMapping = {
  ['<Tab>'] = {
    c = function()
      if cmp.visible() then
        cmp.select_next_item()
      else
        cmp.complete()
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      end
    end,
  },
  ['<S-Tab>'] = {
    c = function()
      if cmp.visible() then
        cmp.select_prev_item()
      else
        cmp.complete()
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      end
    end,
  },
  ['<Down>'] = {
    c = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
  },
  ['<Up>'] = {
    c = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  },
  ['<Esc>'] = {
    c = function()
      if cmp.visible() then
        cmp.close()
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-c>', true, true, true), 'n', true)
      end
    end,
  }
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(cmdlineMapping),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(cmdlineMapping),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
--   border = "rounded",
-- })
