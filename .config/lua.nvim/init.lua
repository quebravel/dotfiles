-- Init
require('opts')
require('keymappings')
require('plugins')
require('appearence')
require('settings')
require('compe-config')

-- Plugins
require('colorizer').setup()
require('gitsigns').setup() -- customizar depois
require('nvim-autopairs').setup{}
require('nvim_comment').setup()

-- lsp https://www.chrisatmachine.com/Neovim/27-native-lsp/
require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}

