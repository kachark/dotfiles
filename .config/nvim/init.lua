
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

g.mapleader = ','


--------- Settings ---------
-- vim.o.background = 'dark'
require('settings')

---------- Plugins ----------
require('plugins')

--------- Key Remaps ---------
-- require('keymappings')
require('config.whichkey').setup()
require('leap').add_default_mappings()

--------- Colorscheme ---------
require('colorscheme')

-------- PLUGIN settings ---------
require('config.lsp')
require('config.statusline')
require('config.treesitter').setup()
require('config.telescope').setup()
require('config.fzf')
require('config.dap')

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


