-- tinted-theme configuration
return {
  "tinted-theming/tinted-vim",
  lazy = false,
  priority = 1000, -- Load theme early
  init = function()
    require("modules.tinted-theme")

    -- load theme overrides
    vim.cmd("source " .. vim.fn.expand("$HOME/.config/vim/theme-overrides.vim"))

    -- fix colorschemes issues
    -- https://github.com/tinted-theming/tinted-vim/issues/103
    -- https://github.com/tinted-theming/tinted-vim/blob/main/templates/tinted-vim.mustache
    -- https://github.com/tinted-theming/base24/blob/main/styling.md
    vim.cmd([[
      function! s:tinted_customize() abort
        "hi! link @variable.member Identifier
        call Tinted_Hi('@variable.member', g:tinted_gui06, '', g:tinted_cterm06, '', '', '')
      endfunction

      " fix colorscheme on startup
      call s:tinted_customize()

      " fix colorcheme on theme change
      augroup on_change_colorschema
        autocmd!
        autocmd ColorScheme * call s:tinted_customize()
      augroup END
    ]])
  end
}
