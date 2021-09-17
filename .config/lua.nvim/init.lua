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

-- lsp
require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}

