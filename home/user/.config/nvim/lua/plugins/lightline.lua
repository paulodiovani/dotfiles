-- Lightline configuration
return {
  "itchyny/lightline.vim",
  dependencies = {
    "mengelbrecht/lightline-bufferline",
    "daviesjamie/vim-base16-lightline"
  },
  config = function()
    -- Lightline config
    vim.opt.laststatus = 2
    vim.opt.showtabline = 2
    vim.g.lightline = {
      colorscheme = 'base16',
      separator = { left = "\u{e0b0}", right = "\u{e0b2}" },
      subseparator = { left = "\u{e0b1}", right = "\u{e0b3}" },
      active = {
        left = {
          { 'mode', 'paste' },
          { 'gitbranch', 'readonly', 'relativepath', 'conflicted', 'modified' }
        }
      },
      inactive = {
        left = {{ 'filename', 'conflicted' }}
      },
      tabline = {
        left = {{ 'buffers' }},
        right = {{ 'close' }, { 'tabs' }}
      },
      component = {
        readonly = '%{&filetype=="help" ? "" : &readonly ? "\u{e0a2}" : ""}',
        gitbranch = "\u{e0a0} %{fugitive#Head()}",
        conflicted = "\u{22b6} %{exists('*ConflictedVersion') ? ConflictedVersion() : ''}",
      },
      component_expand = { buffers = 'lightline#bufferline#buffers' },
      component_type = { buffers = 'tabsel' },
      component_visible_condition = {
        readonly = '(&filetype!="help" && &readonly)',
        gitbranch = '(exists("*fugitive#Head") && "" != fugitive#Head())',
        conflicted = '(exists("*ConflictedVersion") && "" != ConflictedVersion())',
      }
    }
    vim.g['lightline#bufferline#show_number'] = 1
    vim.g['lightline#bufferline#unnamed'] = '[No Name]'
  end
}