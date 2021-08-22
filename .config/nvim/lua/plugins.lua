
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()

  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'mhinz/vim-startify'
  use 'tpope/vim-fugitive'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'neovim/nvim-lspconfig'
  use 'ojroques/nvim-lspfuzzy'
  -- use 'nvim-lua/completion-nvim'
  use 'hrsh7th/nvim-compe'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/plenary.nvim'}}
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  -- Use dependency and run lua function after load
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('config.gitsigns')
    end
  }

  use 'onsails/lspkind-nvim'
  use 'tpope/vim-commentary'

  -- use {'glepnir/galaxyline.nvim', 
  --       branch = 'main',
  --       config = function() require('config.statusline') end,
  --       requires = {'kyazdani42/nvim-web-devicons', opt = true}
  -- }

  use {'famiu/feline.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function() require('config.statusline') end
  }


  -- use 'kyazdani42/nvim-web-devicons'
  use 'iamcco/markdown-preview.nvim'
  use 'folke/lsp-trouble.nvim'
  use {'folke/todo-comments.nvim',
    config = function()
      require('todo-comments').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }

  use {
    'ray-x/lsp_signature.nvim'
  }

  use 'franbach/miramare'
  use 'folke/tokyonight.nvim'
  use 'EdenEast/nightfox.nvim'

end)
