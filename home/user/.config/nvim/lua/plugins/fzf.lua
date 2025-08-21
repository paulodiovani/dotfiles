-- FZF Lua configuration
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  opts = {
    "fzf-vim", -- profile
    winopts = {
      backdrop = 100,
      border = 'rounded',
      height = 0.3,
      row = 1, --bottom
      width = 1,
      preview = {
        border = 'rounded',
        hidden = false,
      },
    },
  },

  init = function()
    local fzf_lua = require("fzf-lua")

    -- register ui select
    fzf_lua.register_ui_select()

    -- Use Rg command to search
    vim.api.nvim_create_user_command('Rg', function(opts)
      fzf_lua.grep({ search = opts.args })
    end, { nargs = '*' })

    -- Use Rgh command to search hidden files
    vim.api.nvim_create_user_command('Rgh', function(opts)
      fzf_lua.grep({
        search = opts.args,
        rg_opts =
        '--hidden --column --line-number --no-heading --color=always --smart-case'
      })
    end, { nargs = '*' })

    -- Check if in a git repo and use git_files, otherwise use files
    vim.api.nvim_create_user_command('Ctrlp', function()
      if vim.fn.exists("*fugitive#Head") == 1 and vim.fn.len(vim.fn.FugitiveHead()) > 0 then
        fzf_lua.git_files()
      else
        fzf_lua.files()
      end
    end, {})
  end,

  cmd = {
    'FzfLua',
  },

  keys = {
    { '<C-p>',      '<Cmd>Ctrlp<CR>',                            mode = { 'n' }, desc = "Smart File Search" },
    { '<Leader>F',  '<Cmd>FzfLua files<CR>',                     mode = { 'n' }, desc = "Find Files" },
    { '<Leader>L',  '<Cmd>FzfLua lines<CR>',                     mode = { 'n' }, desc = "Search Lines in All Buffers" },
    { '<Leader>P',  '<Cmd>FzfLua commands<CR>',                  mode = { 'n' }, desc = "Find Commands" },
    { '<Leader>T',  '<Cmd>FzfLua tags<CR>',                      mode = { 'n' }, desc = "Search Project Tags" },
    { '<Leader>b',  '<Cmd>FzfLua buffers<CR>',                   mode = { 'n' }, desc = "Find Buffers" },
    { '<Leader>l',  '<Cmd>FzfLua blines<CR>',                    mode = { 'n' }, desc = "Search Lines in Current Buffer" },
    { '<Leader>m',  '<Cmd>FzfLua marks<CR>',                     mode = { 'n' }, desc = "Find Marks" },
    { '<Leader>p',  '<Cmd>Ctrlp<CR>',                            mode = { 'n' }, desc = "Smart File Search" },
    { '<Leader>t',  '<Cmd>FzfLua btags<CR>',                     mode = { 'n' }, desc = "Search Buffer Tags" },
    { '<Leader>s',  '<Cmd>FzfLua lsp_document_symbols<CR>',      mode = { 'n' }, desc = "LSP Document Symbols" },
    { '<Leader>S',  '<Cmd>FzfLua lsp_workspace_symbols<CR>',     mode = { 'n' }, desc = "LSP Workspace Symbols" },
    -- lsp features
    { 'gD',         '<Cmd>FzfLua lsp_definitions<CR>',           mode = { 'n' }, desc = "LSP Definitions" },
    { 'grD',        '<Cmd>FzfLua lsp_declarations<CR>',          mode = { 'n' }, desc = "LSP Declarations" },
    { 'grE',        '<Cmd>FzfLua lsp_workspace_diagnostics<CR>', mode = { 'n' }, desc = "LSP Workspace Diagnostics" },
    { 'grS',        '<Cmd>FzfLua lsp_workspace_symbols<CR>',     mode = { 'n' }, desc = "LSP Workspace Symbols" },
    { 'gra',        '<Cmd>FzfLua lsp_code_actions<CR>',          mode = { 'n' }, desc = "LSP Code Actions" },
    { 'grd',        '<Cmd>FzfLua lsp_definitions<CR>',           mode = { 'n' }, desc = "LSP Definitions" },
    { 'gre',        '<Cmd>FzfLua lsp_document_diagnostics<CR>',  mode = { 'n' }, desc = "LSP Document Diagnostics" },
    { 'grg',        '<Cmd>FzfLua tags_grep_cword<CR>',           mode = { 'n' }, desc = "Search in Tags" },
    { 'gri',        '<Cmd>FzfLua lsp_implementations<CR>',       mode = { 'n' }, desc = "LSP Implementations" },
    { 'grr',        '<Cmd>FzfLua lsp_references<CR>',            mode = { 'n' }, desc = "LSP References" },
    { 'grs',        '<Cmd>FzfLua lsp_document_symbols<CR>',      mode = { 'n' }, desc = "LSP Document Symbols" },
    { 'grt',        '<Cmd>FzfLua lsp_typedefs<CR>',              mode = { 'n' }, desc = "LSP Type Definitions" },
    -- search word under cursor or selection
    { '<Leader>rg', '<Cmd>FzfLua grep_cword<CR>',                mode = { 'n' }, desc = "Search Word Under Cursor" },
    { '<Leader>rg', '<Cmd>FzfLua grep_visual<CR>',               mode = { 'v' }, desc = "Search Visual Selection" },
    { '<Leader>rh', 'yiw:Rgh <C-r>"<CR>',                        mode = { 'n' }, desc = "Search Word Under Cursor (Hidden)" },
    { '<Leader>rh', 'y:Rgh <C-r>"<CR>',                          mode = { 'v' }, desc = "Search Visual Selection (Hidden)" },
  },
}
