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
require('config-plugins.lspconfig')

-- Plugins loader without configurations
require('colorizer').setup()
require('nvim-autopairs').setup{}
require('nvim_comment').setup()

