
vim.g.mapleader = ','

-- Set LSP log level --
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)
vim.lsp.inlay_hint.enable()
vim.diagnostic.config({
  -- Use the default configuration
  -- virtual_lines = true

  -- Alternatively, customize specific options
  -- virtual_lines = {
  --  -- Only show virtual line diagnostics for the current cursor line
  --  current_line = true,
  -- },
})
-- vim.opt.guicursor="n-v-c:blinkon10-blinkoff10"

--------- Settings ---------
require('settings') -- options, autocmds
require('defaults').setup() -- icons, styling

---------- Plugins ----------
require('plugins')

--------- Colorscheme ---------
require('colorscheme').setup()

--------- Key Remaps ---------
require('plugins.tools.whichkey').setup()

-------- Plugin settings ---------
require('plugins.core.lsp').setup()
require('plugins.core.blink').setup()
require('plugins.ui.statusline').setup()
require('plugins.core.treesitter').setup()
require('plugins.tools.fzf').setup()
require('plugins.ui.gitsigns').setup()

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

vim.cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'  -- disabled in visual mode

vim.api.nvim_command([[command! Config execute ":e ~/.config/nvim/init.lua"]])
-- vim.api.nvim_command([[command! Reload execute ":source ~/.config/nvim/init.lua"]])


