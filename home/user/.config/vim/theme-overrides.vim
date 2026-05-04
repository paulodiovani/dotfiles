" THEME OVERRIDES

" make line numbers and sign column bg transparent
highlight LineNr ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
" set color of float window and borders
highlight! link FloatBorder LineNr
" use the editor's normal fg/bg for float windows (Float = float-number syntax color)
highlight! link NormalFloat Normal
" remove text background in diagnostics windows
highlight DiagnosticFloatingError guibg=NONE
highlight DiagnosticFloatingWarn guibg=NONE
highlight DiagnosticFloatingInfo guibg=NONE
highlight DiagnosticFloatingHint guibg=NONE
highlight DiagnosticFloatingOk guibg=NONE

" blink.cmp borders: pick up the muted FloatBorder color instead of Pmenu orange
highlight! link BlinkCmpMenuBorder FloatBorder
highlight! link BlinkCmpDocBorder FloatBorder
highlight! link BlinkCmpSignatureHelpBorder FloatBorder
" popup menu (Pmenu) and float backgrounds match the editor;
highlight! link Pmenu NormalFloat
