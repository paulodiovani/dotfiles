-- Completion configuration
return {
  'hrsh7th/nvim-cmp',
  lazy = false,
  dependencies = {
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'onsails/lspkind.nvim',
    'rafamadriz/friendly-snippets',
    'saadparwaiz1/cmp_luasnip',
    'zbirenbaum/copilot-cmp',
    -- 'zbirenbaum/copilot.lua', -- loaded on InsertEnter
  },

  config = function()
    -- Set up luasnip
    local luasnip = require('luasnip')
    require('luasnip.loaders.from_vscode').lazy_load()

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
          luasnip.lsp_expand(args.body)   -- For `luasnip` users.
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
        { name = 'luasnip' },   -- For luasnip users.
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
            Copilot = '',
          },
        })
      }
    })

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
  end,
}
