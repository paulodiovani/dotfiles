" THEME OVERRIDES

" make line numbers and sign column bg transparent
highlight LineNr ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
" set color of float window and borders
highlight! link FloatBorder LineNr
" fix issue with diagnostics windows (or the theme)
highlight! link NormalFloat Float
" remove end of buffer bg
highlight EndOfBuffer guibg=NONE
" remove text background in diagnostics windows
highlight DiagnosticFloatingError guibg=NONE
highlight DiagnosticFloatingWarn guibg=NONE
highlight DiagnosticFloatingInfo guibg=NONE
highlight DiagnosticFloatingHint guibg=NONE
highlight DiagnosticFloatingOk guibg=NONE
