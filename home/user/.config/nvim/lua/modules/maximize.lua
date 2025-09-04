local function maximize()
  -- Get the editor dimensions
  local width = vim.o.columns
  local height = vim.o.lines

  -- Define margins
  local width_margin = 5 -- margins on left and right sides
  local height_margin = 2.5 -- margins on top and bottom

  -- Calculate window dimensions
  local win_width = width - (2 * width_margin)
  local win_height = height - (2 * height_margin)

  -- Calculate position for centering
  local row = height_margin
  local col = width_margin

  -- Open the floating window with the current buffer
  vim.api.nvim_open_win(0, true, {
    relative = "editor",
    row = row,
    col = col,
    width = win_width,
    height = win_height
  })
end

-- set keymap
vim.keymap.set('n', '<C-W>z', maximize, { desc = 'Maximize current buffer in a floating window' })
