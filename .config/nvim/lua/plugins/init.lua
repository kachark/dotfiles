
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

return require("lazy").setup({

  -- **************************
  -- Necessary
  -- **************************
  'nvim-lua/plenary.nvim',
  'mhinz/vim-startify',
  -- Needed for svelte commenting (not support in Nvim 0.10)
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  'tpope/vim-repeat',
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },
  {
    'echasnovski/mini.pairs',
    version = '*',
    config = function()
      require('mini.pairs').setup({})
    end
  },

  -- **************************
  -- Misc.
  -- **************************
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
      input = { enabled = true },
      picker = { enabled = false },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
    },
  },

  -- **************************
  -- Git
  -- **************************
  'tpope/vim-fugitive',
  {
    'lewis6991/gitsigns.nvim',
    -- setup later in config/gitsigns.lua
    lazy = true,
  },

  -- **************************
  -- Debugger
  -- **************************
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'
    },
    -- setup later by config/dap.lua
    lazy = true,
  },

  -- **************************
  -- LSP
  -- **************************
  {
    'neovim/nvim-lspconfig',
    -- setup later by my config/lsp.lua
    lazy = true,
  },
  'ray-x/lsp_signature.nvim',
  'nvim-lua/popup.nvim',

  -- **************************
  -- LSP diagnostic popups
  -- **************************
  {
    "folke/trouble.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons"
    },
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        width = 50,
      }
    end,
  },

  {
    'folke/todo-comments.nvim',
    config = function()
      require('todo-comments').setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  },

  -- **************************
  -- Buffer/file/grep
  -- **************************
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    },
  },

  -- **************************
  -- Language specific
  -- **************************
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    -- opts = {},
  },

  -- **************************
  -- Completion engine
  -- **************************
  {
    'hrsh7th/nvim-cmp',
    version = false,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp', -- source for lsp
      'hrsh7th/cmp-nvim-lua', -- source for lua
      'hrsh7th/cmp-buffer', -- source for buffer
      "saadparwaiz1/cmp_luasnip",
    },
    -- setup later in config/lsp.lua
    lazy = true,
  },

  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    }
  },

  {
    'saghen/blink.cmp',
    dependencies = {
      -- optional: provides snippets for the snippet source
      'rafamadriz/friendly-snippets',
      -- optional: icons in completion menu
      'onsails/lspkind.nvim',
      'kyazdani42/nvim-web-devicons',
    },

    -- use a release tag to download pre-built binaries
    version = '*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    -- setup later in config/blink.lua
    lazy = true,
  },

  -- **************************
  -- Statusline
  -- **************************
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'kyazdani42/nvim-web-devicons',
    },
    -- setup later in config/statusline.lua
    lazy = true,
  },

  -- **************************
  -- Scrollbar
  -- **************************
  'petertriho/nvim-scrollbar',

  -- **************************
  -- Hotkey plugins
  -- **************************
  {
    'folke/which-key.nvim',
    -- setup later in config/whichkey.lua
    lazy = true,
  },

  -- **************************
  -- Movement
  -- **************************
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- **************************
  -- Highlighting and code inference
  -- **************************
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    -- setup later in config/treesitter.lua
    lazy = true,
  },
  -- {
  --   'RRethy/vim-illuminate',
  --   config = function()
  --     require('illuminate').configure({
  --       opts = {
  --         delay = 200,
  --         large_file_cutoff = 2000,
  --         large_file_overrides = {
  --           providers = { "lsp" },
  --         },
  --       },
  --     })
  --   end
  -- },
  {
    'brenoprata10/nvim-highlight-colors',
    config = function()
      require('nvim-highlight-colors').setup({
        enable_named_colors = false,
        enable_tailwind = true,
      })
    end,
  },

  -- **************************
  -- Colorschemes
  -- **************************
  'franbach/miramare',
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  'rebelot/kanagawa.nvim',
  'Mofiqul/dracula.nvim',
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    -- Make colorscheme available at plugin load-time
    lazy = false,
    priority = 1000,
    config = function()
      require('colorscheme').setup()
    end,
  },
  'luisiacc/gruvbox-baby',
  {
    'miikanissi/modus-themes.nvim',
    priority = 1000
  },

})
