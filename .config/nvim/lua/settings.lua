
-- define a function to set options in either
  -- global ('o'), buffer ('bo'), window ('wo') scopes
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
local function opt(scope, key, value)
  scopes[scope][key] = value
  if scope ~= 'o' then scopes['o'][key] = value end
end


local indent = 2
opt('b', 'expandtab', true)                           -- Use spaces instead of tabs
opt('b', 'shiftwidth', indent)                        -- Size of an indent
opt('b', 'smartindent', true)                         -- Insert indents automatically
opt('b', 'tabstop', indent)                           -- Number of spaces tabs count for
opt('o', 'completeopt', 'menuone,noinsert,noselect,preview')  -- Completion options
opt('o', 'hidden', true)                              -- Enable modified buffers in background
opt('o', 'ignorecase', true)                          -- Ignore case
opt('o', 'joinspaces', false)                         -- No double spaces with join after a dot
opt('o', 'scrolloff', 10 )                             -- Lines of context
opt('o', 'shiftround', true)                          -- Round indent
opt('o', 'sidescrolloff', 8 )                         -- Columns of context
opt('o', 'smartcase', true)                           -- Don't ignore case with capitals
opt('o', 'splitbelow', true)                          -- Put new windows below current
opt('o', 'splitright', true)                          -- Put new windows right of current
opt('o', 'wildmode', 'list:longest')                  -- Command-line completion mode
opt('w', 'list', true)                                -- Show some invisible characters (tabs...)
opt('w', 'number', true)                              -- Print line number
opt('w', 'relativenumber', true)                      -- Relative line numbers
opt('w', 'wrap', false)                               -- Disable line wrap

-- function nvim_create_augroups(definitions)
--   for group_name, definition in pairs(definitions) do
--     vim.api.nvim_command('augroup '..group_name)
--     vim.api.nvim_command('autocmd!')
--     for _, def in ipairs(definition) do
--       local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
--       vim.api.nvim_command(command)
--     end
--     vim.api.nvim_command('augroup END')
--   end
-- end


-- function set_cursor_column()
--   if vim.api.nvim_command('get(w:, "paren_hl_on", 0)') then
--     opt('w', 'cursorcolumn', 'true')
--   else
--     opt('w', 'nocursorcolumn', 'true')
--   end
-- end


-- local autocmds = {
--   startup = {
--     {"CursorMoved", "*", [[lua set_cursor_column()]]};
--     {"InsertEnter", "*", [[lua opt('w', 'nocursorcolumn', 'true')]]};
--   }
-- }

-- function matchparen_cursorcolumn()
--   nvim_create_augroups(autocmds)
-- end


-- define function
-- -- " massively simplified take on https://github.com/chreekat/vim-paren-crosshairs
-- func! s:matchparen_cursorcolumn_setup()
--   augroup matchparen_cursorcolumn
--     autocmd!
--     autocmd CursorMoved * if get(w:, "paren_hl_on", 0) | set cursorcolumn | else | set nocursorcolumn | endif
--     autocmd InsertEnter * set nocursorcolumn
--   augroup END
-- endf

-- use the function
-- if !&cursorcolumn
--   augroup matchparen_cursorcolumn_setup
--     autocmd!
--     " - Add the event _only_ if matchparen is enabled.
--     " - Event must be added _after_ matchparen loaded (so we can react to w:paren_hl_on).
--     autocmd CursorMoved * if exists("#matchparen#CursorMoved") | call <sid>matchparen_cursorcolumn_setup() | endif
--           \ | autocmd! matchparen_cursorcolumn_setup
--   augroup END
-- endif
