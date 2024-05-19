
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g

g.mapleader = ','

-- Set LSP log level --
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)
vim.lsp.inlay_hint.enable()

--------- Settings ---------
require('settings') -- options, autocmds
require('defaults').setup() -- icons, styling

---------- Plugins ----------
require('plugins')

--------- Key Remaps ---------
-- require('keymappings')
require('plugins.whichkey').setup()

-------- Plugin settings ---------
require('plugins.lsp').setup()
require('plugins.statusline').setup()
require('plugins.treesitter').setup()
require('plugins.telescope').setup()
require('plugins.fzf').setup()
require('plugins.dap').setup()
require('plugins.gitsigns').setup()
require('plugins.dressing').setup()

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


