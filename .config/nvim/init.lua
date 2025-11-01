
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
require('settings').setup() -- options, autocmds
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
require('plugins.ui.minifiles').setup()

--------- Commands ---------

-- Highlight yanked text (disabled in visual mode)
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { on_visual = false }
  end,
})

-- Custom command to open config
vim.api.nvim_create_user_command("Config", function()
  vim.cmd("e ~/.config/nvim/init.lua")
end, { desc = "Open Neovim configuration" })


