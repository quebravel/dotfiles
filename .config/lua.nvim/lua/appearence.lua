-- Lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', {'diff', colored = true, color_added = '#b8bb26', color_modified = '#fabd2f', color_removed = '#fbf1c7'}},
    lualine_c = {'filename'},
    lualine_x = {'hostname', 'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
    extensions = {'nvim-tree', 'fugitive'}
}

-- Color scheme
vim.cmd[[colorscheme tokyonight]]
vim.g.tokyonight_style = "night"

-- configuração para bufferline
require("bufferline").setup{
      options = {
                  show_buffer_close_icons = false,
                  close_icon = 'x',
                  modified_icon = '●',
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

require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~!', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
}
