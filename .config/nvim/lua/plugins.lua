
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Necessary
  use 'nvim-lua/plenary.nvim'
  use 'mhinz/vim-startify'
  use 'tpope/vim-commentary'

  -- Git
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('config.gitsigns')
    end
  }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  use 'ojroques/nvim-lspfuzzy' use 'nvim-lua/popup.nvim'
  use 'ray-x/lsp_signature.nvim'

  use 'folke/lsp-colors.nvim'

  -- LSP diagnostic popups
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        width = 50,
      }
    end
  }

  use {'folke/todo-comments.nvim',
    config = function()
      require('todo-comments').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  -- Buffer/file/grep
  -- use {
  --   'nvim-telescope/telescope.nvim',
  --   requires = {{'nvim-lua/plenary.nvim'}}
  -- }
  -- use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'ibhagwan/fzf-lua',
    -- optional for icon support
    requires = { 'kyazdani42/nvim-web-devicons' }
  }

  -- Language specific
  use 'simrat39/rust-tools.nvim'
  use 'iamcco/markdown-preview.nvim'

  -- Completion engine
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- Scrollbar
  use 'petertriho/nvim-scrollbar'

  -- Movement
  use 'ggandor/lightspeed.nvim'

  -- Highlighting and code inference
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  -- Colorschemes
  use 'franbach/miramare'
  use 'folke/tokyonight.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'rebelot/kanagawa.nvim'

end)
