-- Init
require('opts')
require('keymappings')
require('plugins')
require('appearence')
require('settings')
require('config-plugins.compe-config')
require('config-plugins.nvim-treesitter-config')
require('config-plugins.nvim-lspinstall')

-- Plugins
require('colorizer').setup()
require('nvim-autopairs').setup{}
require('nvim_comment').setup()

-- lsp https://www.chrisatmachine.com/Neovim/27-native-lsp/
require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}

