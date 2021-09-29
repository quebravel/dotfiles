-- Init
require('opts')
require('keymappings')
require('plugins')
require('appearence')

-- Plugins configurations
require('config-plugins.cmp')
require('config-plugins.tree')
require('config-plugins.treesitter')
require('config-plugins.dashboard')
require('config-plugins.lspinstall')

-- Plugins loader without configurations
require('colorizer').setup()
require('nvim-autopairs').setup{}
require('nvim_comment').setup()

-- lsp https://www.chrisatmachine.com/Neovim/27-native-lsp/
require'lspconfig'.pyright.setup{}
require'lspconfig'.bashls.setup{}

