return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",

  opts = {
    default = {
      -- use current filename as media folder
      dir_path = function()
        return "assets/media/" .. vim.fn.expand("%:t:r")
      end,
      prompt_for_file_name = true,
      show_dir_path_in_prompt = true,
    },
    filetypes = {
      markdown = {
        template = "![$LABEL$CURSOR]($FILE_PATH)",
      },
    },
  },

  init = function()
    -- alias ImgClipPaste command
    vim.api.nvim_create_user_command('ImgClipPaste', 'PasteImage', {})
  end,

  cmd = {
    'ImgClipConfig',
    'ImgClipDebug',
    'PasteImage',
  },
}
