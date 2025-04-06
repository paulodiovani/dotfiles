-- FZF configuration
return {
  "junegunn/fzf.vim",
  dependencies = { "junegunn/fzf" },
  config = function()
    -- FZF config
    vim.g.fzf_buffers_jump = 1
    vim.g.fzf_layout = { window = 'botright 15new' }
    vim.g.fzf_commits_log_options = '--format="%C(yellow)%h %ad%C(reset) %C(auto)| %s%d %C(cyan)[%an]" --date=short'
    vim.g.fzf_colors = {
      ['fg']      = {'fg', 'Normal'},
      ['bg']      = {'bg', 'Normal'},
      ['hl']      = {'fg', 'Comment'},
      ['fg+']     = {'fg', 'CursorLine', 'CursorColumn', 'Normal'},
      ['bg+']     = {'bg', 'CursorLine', 'CursorColumn'},
      ['hl+']     = {'fg', 'Statement'},
      ['info']    = {'fg', 'PreProc'},
      ['border']  = {'fg', 'Ignore'},
      ['prompt']  = {'fg', 'Conditional'},
      ['pointer'] = {'fg', 'Exception'},
      ['marker']  = {'fg', 'Keyword'},
      ['spinner'] = {'fg', 'Label'},
      ['header']  = {'fg', 'Comment'}
    }

    -- Custom command for GFiles/Files switching
    vim.cmd([[command! Ctrlp execute (exists("*fugitive#Head") && len(fugitive#Head())) ? "execute 'GFiles ' . getcwd()" : 'Files']])

    -- Search with ripgrep including hidden files
    vim.cmd([[command! -bang -nargs=* Rgh call fzf#vim#grep("rg --hidden --column --line-number --no-heading --color=always --smart-case -- ".fzf#shellescape(<q-args>), fzf#vim#with_preview(), <bang>0)]])

    -- Key mappings
    vim.keymap.set('n', '<C-p>', ':Ctrlp<CR>', { silent = true })
    vim.keymap.set('n', '<Leader>p', ':Ctrlp<CR>', { silent = true })
    vim.keymap.set('n', '<Leader>P', ':Files<CR>', { silent = true })
    vim.keymap.set('n', '<Leader>b', ':Buffers<CR>', { silent = true })
    vim.keymap.set('n', '<Leader>t', ':BTags<CR>', { silent = true })
    vim.keymap.set('n', '<Leader>T', ':Tags<CR>', { silent = true })
    vim.keymap.set('n', '<Leader>l', ':BLines<CR>', { silent = true })
    vim.keymap.set('n', '<Leader>L', ':Lines<CR>', { silent = true })
    vim.keymap.set('n', '<Leader>m', ':Marks<CR>', { silent = true })
    vim.keymap.set('n', '<Leader>rg', 'yiw:Rg <C-r>"', { noremap = true })
    vim.keymap.set('v', '<Leader>rg', 'y:Rg <C-r>"', { noremap = true })
    vim.keymap.set('n', '<Leader>rh', 'yiw:Rgh <C-r>"', { noremap = true })
    vim.keymap.set('v', '<Leader>rh', 'y:Rgh <C-r>"', { noremap = true })
  end
}
