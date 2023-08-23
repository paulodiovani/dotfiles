-- luacheck: globals vim

-- GitHub Copilot config
require('copilot').setup({
  -- Set enable = true until this bug is fixed:
  -- https://github.com/zbirenbaum/copilot-cmp/issues/10
  suggestion = { enabled = true, auto_trigger = false },
  panel = { enabled = false },
})

require('copilot_cmp').setup()

-- Set up nvim-cmp.
local cmp = require 'cmp'
local cmp_config_default = require('cmp.config.default')()
local copilot_prioritize = require('copilot_cmp.comparators').prioritize

-- move copilot down
local copilot_reverse_prioritize = function(entry1, entry2)
  return not copilot_prioritize(entry1, entry2)
end

---@cast cmp -nil
cmp.setup({
  completion = {
    autocomplete = false,
    completeopt = 'menu',
  },
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
    { name = 'copilot' },
    { name = 'buffer' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }),
  sorting = {
    comparators = table.insert(cmp_config_default.sorting.comparators, 1, copilot_reverse_prioritize),
  },
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

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
local servers = { 'bashls', 'lua_ls', 'solargraph', 'tsserver', 'vimls' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    capabilities = capabilities,

    on_attach = function(_, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
      vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set({ 'n', 'i' }, '<Leader><F2>', vim.lsp.buf.rename, bufopts)
      vim.keymap.set({ 'n', 'i' }, '<F12>', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', '<Leader><F12>', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set({ 'n', 'i' }, '<F9>', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
    end
  })
end

local lspkind = require('lspkind')
cmp.setup {
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
}
