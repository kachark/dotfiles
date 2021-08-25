
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

g.mapleader = ','


--------- Settings ---------
-- vim.o.background = 'dark'
require('settings')
require('colorscheme')

--------- Key Remaps ---------
require('keymappings')

---------- Plugins ----------
require('plugins')

-------- PLUGIN settings ---------
require('config.lsp')
require('config.statusline')

--- Telescope ---
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        -- etc
        ["<esc>"] = actions.close,
      },
      n = {
        -- etc
        ["<esc>"] = actions.close,
      },
    },
  }
}

--- TreeSitter ---

local treesitter = require 'nvim-treesitter.configs'
treesitter.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { },  -- list of language that will be disabled
  },
}

treesitter.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}


--- devicons ---

require'nvim-web-devicons'.setup {
  -- your personnal icons can go here (to override)
  -- DevIcon will be appended to `name`
  override = {
    zsh = {
      icon = "",
      color = "#428850",
      name = "Zsh"
    }
  };
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true;
}

--------- Commands ---------

-- completion.nvim
-- cmd 'BufEnter * lua require'completion'.on_attach()' -- use completion-nvim on every buffer
-- vim.api.nvim_command([[autocmd BufEnter * lua require'completion'.on_attach()]])

cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  -- disabled in visual mode

vim.api.nvim_command([[command! Config execute ":e ~/.config/nvim/init.lua"]])
-- vim.api.nvim_command([[command! Reload execute ":source ~/.config/nvim/init.lua"]])


