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
  end,

  cmd = {
    'FzfLua',
  },

  keys = {
    { '<C-p>',      '<Cmd>FzfLua git_files<CR>',   mode = { 'n' } },
    { '<Leader>p',  '<Cmd>FzfLua git_files<CR>',   mode = { 'n' } },
    { '<Leader>P',  '<Cmd>FzfLua files<CR>',       mode = { 'n' } },
    { '<Leader>b',  '<Cmd>FzfLua buffers<CR>',     mode = { 'n' } },
    { '<Leader>t',  '<Cmd>FzfLua btags<CR>',       mode = { 'n' } },
    { '<Leader>T',  '<Cmd>FzfLua tags<CR>',        mode = { 'n' } },
    { '<Leader>l',  '<Cmd>FzfLua blines<CR>',      mode = { 'n' } },
    { '<Leader>L',  '<Cmd>FzfLua lines<CR>',       mode = { 'n' } },
    { '<Leader>m',  '<Cmd>FzfLua marks<CR>',       mode = { 'n' } },
    -- search word under cursor or selection
    { '<Leader>rg', '<Cmd>FzfLua grep_cword<CR>',  mode = { 'n' } },
    { '<Leader>rg', '<Cmd>FzfLua grep_visual<CR>', mode = { 'v' } },
    { '<Leader>rh', 'yiw:Rgh <C-r>"<CR>',          mode = { 'n' } },
    { '<Leader>rh', 'y:Rgh <C-r>"<CR>',            mode = { 'v' } },
  },
}
