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

packer.reset()

packer.startup(function()

  packer.use {
    'wbthomason/packer.nvim',
    opt = false
  }

  packer.use 'windwp/nvim-autopairs'
  packer.use 'folke/tokyonight.nvim'
  packer.use 'morhetz/gruvbox'
  packer.use 'sheerun/vim-polyglot'
  packer.use 'kyazdani42/nvim-web-devicons'
  packer.use 'ryanoasis/vim-devicons'
  packer.use 'tpope/vim-fugitive'

  packer.use {
      'hoob3rt/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
   }
      
  packer.use {
      'akinsho/bufferline.nvim',
      requires = 'kyazdani42/nvim-web-devicons'
   }
  packer.use 'lukas-reineke/indent-blankline.nvim'
  packer.use 'norcalli/nvim-colorizer.lua'

  packer.use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' }
   }
  packer.use 'andymass/vim-matchup'
  packer.use 'terrortylor/nvim-comment'

  packer.use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
}
  -- packer.use {
--      "rafamadriz/friendly-snippets",
--      event = "InsertEnter",
--   }
--
--  packer.use {
--      "hrsh7th/nvim-cmp",
--      after = "friendly-snippets",
--      config = function()
--         require "plugins.configs.cmp"
--      end,
--   }
--
--   packer.use {
--      "L3MON4D3/LuaSnip",
--      wants = "friendly-snippets",
--      after = "nvim-cmp",
--      config = function()
--         require("plugins.configs.others").luasnip()
--      end,
--   }
--
--   packer.use {
--      "saadparwaiz1/cmp_luasnip",
--      after = "LuaSnip",
--   }
--
--   packer.use {
--      "hrsh7th/cmp-nvim-lua",
--      after = "cmp_luasnip",
--   }
--
--   packer.use {
--      "hrsh7th/cmp-nvim-lsp",
--      after = "cmp-nvim-lua",
--   }
--
--   packer.use {
--      "hrsh7th/cmp-buffer",
--      after = "cmp-nvim-lsp",
--   }


end)
