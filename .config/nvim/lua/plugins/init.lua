
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
  'nvim-lua/popup.nvim',
  'mhinz/vim-startify',
  -- -- Needed for svelte commenting (not support in Nvim 0.10)
  -- {
  --   'numToStr/Comment.nvim',
  --   config = function()
  --     require('Comment').setup()
  --   end,
  -- },
  'tpope/vim-repeat',
  {
    "kylechui/nvim-surround",
    version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },
  {
    'echasnovski/mini.pairs',
    version = false,
    config = function()
      require('mini.pairs').setup({})
    end,
    lazy = true,
  },
  {
    "echasnovski/mini.icons",
    opts = {
      -- Add custom icon overrides
      extension = {
        zsh = { glyph = "", hl = "MiniIconsGreen" },
      },
    },
    lazy = false,
    priority = 1000,
    specs = {
      { "nvim-tree/nvim-web-devicons", enabled = false, optional = true },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  -- **************************
  -- Misc.
  -- **************************
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      -- Enable improved input/select UI (replaces dressing.nvim)
      input = {
        enabled = true,
        -- Enhanced input styling
        win = {
          relative = "cursor",
          row = -3,
          col = 0,
        },
      },
      -- Keep other features disabled for minimal setup
      bigfile = { enabled = false },
      dashboard = { enabled = false },
      explorer = { enabled = false },
      indent = { enabled = false },
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
    lazy = true,
  },


  -- **************************
  -- LSP
  -- **************************
  {
    'neovim/nvim-lspconfig',
    lazy = true,
  },

  -- **************************
  -- LSP diagnostic popups
  -- **************************
  {
    "folke/trouble.nvim",
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
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
    end,
  },

  -- **************************
  -- Buffer/file/grep + find-and-replace
  -- **************************
  {
    'ibhagwan/fzf-lua',
  },
  {
    'MagicDuck/grug-far.nvim',
    -- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
    -- additional lazy config to defer loading is not really needed...
    config = function()
      -- optional setup call to override plugin options
      -- alternatively you can set options with vim.g.grug_far = { ... }
      require('grug-far').setup({
        -- options, see Configuration section below
        -- there are no required options atm
      });
    end
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    'nvim-mini/mini.files',
    version = '*',
  },

  -- **************************
  -- Language specific
  -- **************************
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
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
  -- UI
  -- **************************
  {
    'nvim-lualine/lualine.nvim',
    lazy = true,
  },
  'petertriho/nvim-scrollbar',

  -- **************************
  -- Hotkey plugins
  -- **************************
  {
    'folke/which-key.nvim',
    lazy = true,
  },

  -- **************************
  -- Movement
  -- **************************
  {
    "folke/flash.nvim",
    event = "VeryLazy",
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
  {
    'saghen/blink.cmp',
    dependencies = {
      -- optional: provides snippets for the snippet source
      'rafamadriz/friendly-snippets',
      -- optional: icons in completion menu
      'onsails/lspkind.nvim',
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
    lazy = false,
    priority = 1000,
  },
  'luisiacc/gruvbox-baby',
  {
    'miikanissi/modus-themes.nvim',
    priority = 1000
  },

})
