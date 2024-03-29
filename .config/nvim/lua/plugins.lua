-- fazer o git clone
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

packer = require 'packer'
packer.init {
    opt_default = false, -- Default to using opt (as opposed to start) plugins
    display = {
      open_fn  = nil, -- An optional function to open a window for packer's display
      open_cmd = '65vnew \\[packer\\]', -- An optional command to open a window for packer's display
      working_sym = '⟳', -- The symbol for a plugin being installed/updated
      error_sym = '✗', -- The symbol for a plugin with an error in installation/updating
      done_sym = '✓', -- The symbol for a plugin which has completed installation/updating
      removed_sym = '-', -- The symbol for an unused plugin which was removed
      moved_sym = '→', -- The symbol for a plugin which was moved (e.g. from opt to start)
      header_sym = '━', -- The symbol for the header line in packer's display
      show_all_info = true, -- Should packer show all update details automatically?
      prompt_border = 'double', -- Border style of prompt popups.
    }
}

local use = packer.use

packer.reset()

packer.startup(function()

  packer.use {
    'wbthomason/packer.nvim',
    opt = false
  }

  -- use "NvChad/nvim-base16.lua"
  use 'windwp/nvim-autopairs'
  use 'folke/tokyonight.nvim'
  use { 'ellisonleao/gruvbox.nvim', requires = { 'rktjmp/lush.nvim' } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'sheerun/vim-polyglot'
  use 'kyazdani42/nvim-web-devicons'
  use 'ryanoasis/vim-devicons'
  use 'tpope/vim-fugitive'
  use 'glepnir/dashboard-nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'folke/zen-mode.nvim'

  use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc' } } -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  use { 'hoob3rt/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use { 'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons' }
  use 'norcalli/nvim-colorizer.lua'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'andymass/vim-matchup'
  use 'terrortylor/nvim-comment'
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }

end)
