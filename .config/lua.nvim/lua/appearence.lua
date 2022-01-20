-- Lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    section_separators = {'', ''},
    component_separators = {'', ''}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', {
      'diff', colored = true,
      diff_color = {
        -- Same color values as the general color option can be used here.
        added    = 'DiffAdd',    -- Changes the diff's added color
        modified = 'DiffChange', -- Changes the diff's modified color
        removed  = 'DiffDelete', -- Changes the diff's removed color you
      },
    }
                },
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
-- vim.g.gruvbox_contrast_dark = "hard"

-- configuração para bufferline
require("bufferline").setup{
      options = {
                  show_buffer_close_icons = false,
                  close_icon = 'x',
                  modified_icon = '●',
                  show_tab_indicators = false,
                  offsets = {
                    {
                      filetype = "NvimTree",
                      text = "File Explorer NvimTree",
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
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = true, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
}
