-- Lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
  },
}

-- Color scheme
vim.cmd[[colorscheme tokyonight]]

-- Color scheme
vim.g.tokyonight_style = "night"

-- configuração para bufferline
require("bufferline").setup{
      options = {
                  show_buffer_close_icons = false,
                  offsets = {
                    {
                      filetype = "NvimTree",
                      text = "File Explorer",
                      highlight = "Directory",
                      text_align = "left"
                    }
                    }
      }
}

