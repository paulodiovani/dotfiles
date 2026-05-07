-- Completion configuration (blink.cmp)
return {
  'saghen/blink.cmp',
  version = '~1',
  dependencies = {
    { 'L3MON4D3/LuaSnip', version = '~2' },
    'rafamadriz/friendly-snippets',
    'fang2hou/blink-copilot',
    'mayromr/blink-cmp-dap',
  },
  event = 'VeryLazy',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset      = 'default',
      ['<C-s>']   = { 'show_signature', 'hide_signature', 'fallback' },
      ['<CR>']    = { 'accept', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<Tab>']   = { 'select_next', 'snippet_forward', 'fallback' },
    },

    completion = {
      menu = {
        auto_show = false,
        border = 'rounded',
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label',      'label_description', gap = 1 },
            { 'source_name' },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
      },
      list = { selection = { preselect = true, auto_insert = false } },
    },

    snippets = { preset = 'luasnip' },

    sources = {
      default = { 'lsp', 'path', 'copilot', 'snippets', 'buffer' },
      per_filetype = {
        ['dap-repl'] = { 'dap', 'buffer' },
        ['dapui_watches'] = { 'dap', 'buffer' },
        ['dapui_hover'] = { 'dap', 'buffer' },
      },
      providers = {
        copilot = {
          name = 'Copilot',
          module = 'blink-copilot',
          score_offset = -1,
          async = true,
        },
        dap     = {
          name = 'DAP',
          module = 'blink-cmp-dap',
          score_offset = 1,
        },
      },
    },

    cmdline = {
      enabled = true,
      keymap = {
        preset     = 'cmdline',
        ['<Up>']   = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
      },
      completion = { menu = { auto_show = false } },
    },

    fuzzy = { implementation = 'prefer_rust_with_warning' },

    signature = {
      enabled = true,
      window = { border = 'rounded' },
    },
  },

  config = function(_, opts)
    require('blink.cmp').setup(opts)
    require('luasnip.loaders.from_vscode').lazy_load()
  end,
}
