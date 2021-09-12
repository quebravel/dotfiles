require('opts')
require('keymappings')
require('plugins')

-- bufferline
require("bufferline").setup{}

-- lualine
require('lualine').setup{
    options = {theme = 'dracula'},
}

-- Indent-blankline
require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
        "IndentBlanklineIndent3",
        "IndentBlanklineIndent4",
        "IndentBlanklineIndent5",
        "IndentBlanklineIndent6",
    },
}

require'colorizer'.setup()
require('gitsigns').setup() -- customizar depois
require('nvim-autopairs').setup{}
require('nvim_comment').setup()

