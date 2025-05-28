return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",

  opts = {
    default = {
      prompt_for_file_name = true,
      show_dir_path_in_prompt = true,
    },
    filetypes = {
      markdown = {
        template = "![$FILE_NAME_NO_EXT$CURSOR]($FILE_PATH)",
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
