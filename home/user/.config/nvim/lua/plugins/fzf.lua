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
    -- Use Rg command to search
    vim.api.nvim_create_user_command('Rg', function(opts)
      require('fzf-lua').grep({ search = opts.args })
    end, { nargs = '*' })

    -- Use Rgh command to search hidden files
    vim.api.nvim_create_user_command('Rgh', function(opts)
      require('fzf-lua').grep({
        search = opts.args,
        rg_opts =
        '--hidden --column --line-number --no-heading --color=always --smart-case'
      })
    end, { nargs = '*' })

    -- Check if in a git repo and use git_files, otherwise use files
    vim.api.nvim_create_user_command('Ctrlp', function(opts)
      if vim.fn.exists("*fugitive#Head") == 1 and vim.fn.len(vim.fn.FugitiveHead()) > 0 then
        require('fzf-lua').git_files()
      else
        require('fzf-lua').files()
      end
    end, {})
  end,

  cmd = {
    'FzfLua',
  },

  keys = {
    { '<C-p>',      '<Cmd>Ctrlp<CR>',                            mode = { 'n' } },
    { '<C-P>',      '<Cmd>FzfLua commands<CR>',                  mode = { 'n' } },
    { '<Leader>p',  '<Cmd>Ctrlp<CR>',                            mode = { 'n' } },
    { '<Leader>P',  '<Cmd>FzfLua files<CR>',                     mode = { 'n' } },
    { '<Leader>b',  '<Cmd>FzfLua buffers<CR>',                   mode = { 'n' } },
    { '<Leader>t',  '<Cmd>FzfLua btags<CR>',                     mode = { 'n' } },
    { '<Leader>T',  '<Cmd>FzfLua tags<CR>',                      mode = { 'n' } },
    { '<Leader>l',  '<Cmd>FzfLua blines<CR>',                    mode = { 'n' } },
    { '<Leader>L',  '<Cmd>FzfLua lines<CR>',                     mode = { 'n' } },
    { '<Leader>m',  '<Cmd>FzfLua marks<CR>',                     mode = { 'n' } },
    -- lsp features
    { 'gra',        '<Cmd>FzfLua lsp_code_actions<CR>',          mode = { 'n' }, desc = "LSP Code Actions" },
    { 'gri',        '<Cmd>FzfLua lsp_implementations<CR>',       mode = { 'n' }, desc = "LSP Implementations" },
    { 'grr',        '<Cmd>FzfLua lsp_references<CR>',            mode = { 'n' }, desc = "LSP References" },
    { 'grd',        '<Cmd>FzfLua lsp_definitions<CR>',           mode = { 'n' }, desc = "LSP Definitions" },
    { 'grt',        '<Cmd>FzfLua lsp_typedefs<CR>',              mode = { 'n' }, desc = "LSP Type Definitions" },
    { 'grD',        '<Cmd>FzfLua lsp_declarations<CR>',          mode = { 'n' }, desc = "LSP Declarations" },
    { 'grs',        '<Cmd>FzfLua lsp_document_symbols<CR>',      mode = { 'n' }, desc = "LSP Document Symbols" },
    { 'grS',        '<Cmd>FzfLua lsp_workspace_symbols<CR>',     mode = { 'n' }, desc = "LSP Workspace Symbols" },
    { 'gre',        '<Cmd>FzfLua lsp_document_diagnostics<CR>',  mode = { 'n' }, desc = "LSP Document Diagnostics" },
    { 'grE',        '<Cmd>FzfLua lsp_workspace_diagnostics<CR>', mode = { 'n' }, desc = "LSP Workspace Diagnostics" },
    -- search word under cursor or selection
    { '<Leader>rg', '<Cmd>FzfLua grep_cword<CR>',                mode = { 'n' } },
    { '<Leader>rg', '<Cmd>FzfLua grep_visual<CR>',               mode = { 'v' } },
    { '<Leader>rh', 'yiw:Rgh <C-r>"<CR>',                        mode = { 'n' } },
    { '<Leader>rh', 'y:Rgh <C-r>"<CR>',                          mode = { 'v' } },
  },
}
