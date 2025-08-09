
local M = {}

function M.setup()
  local opt = vim.opt

  opt.title = true
  
  -- Indentation
  opt.expandtab = true                    -- Use spaces instead of tabs
  opt.shiftwidth = 2                      -- Size of an indent
  opt.smartindent = true                  -- Insert indents automatically
  opt.tabstop = 2                         -- Number of spaces tabs count for
  
  -- Completion
  opt.completeopt = 'menuone,noinsert,noselect,preview'  -- Completion options
  
  -- General behavior
  opt.hidden = true                       -- Enable modified buffers in background
  opt.ignorecase = true                   -- Ignore case
  opt.smartcase = true                    -- Don't ignore case with capitals
  opt.joinspaces = false                  -- No double spaces with join after a dot
  
  -- Scrolling and context
  opt.scrolloff = 10                      -- Lines of context
  opt.sidescrolloff = 8                   -- Columns of context
  
  -- Indentation behavior
  opt.shiftround = true                   -- Round indent
  
  -- Window splitting
  opt.splitbelow = true                   -- Put new windows below current
  opt.splitright = true                   -- Put new windows right of current
  
  -- Command line
  opt.wildmode = 'list:longest'           -- Command-line completion mode
  
  -- Display
  opt.list = true                         -- Show some invisible characters (tabs...)
  opt.number = true                       -- Print line number
  opt.relativenumber = true               -- Relative line numbers
  opt.wrap = false                        -- Disable line wrap
end

return M
