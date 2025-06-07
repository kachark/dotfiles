
-- define function to easily configure key mappings
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opts = { noremap=true, silent=true }

map('', '<leader>c', '"+y')       -- Copy to clipboard in normal, visual, select and operator modes
map('i', '<C-u>', '<C-g>u<C-u>')  -- Make <C-u> undo-friendly
map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly


map('n', '<leader>1', '<cmd>noh<CR>')    -- Clear highlights
map('n', '<leader>o', 'm`o<Esc>``')  -- Insert a newline in normal mode
map('n', '<leader>q', '<C-^>') -- hotkey to swap between current and previous file

-- split navigations
map('n', '<C-j>', '<C-w><C-j>')
map('n', '<C-k>', '<C-w><C-k>')
map('n', '<C-l>', '<C-w><C-l>')
map('n', '<C-h>', '<C-w><C-h>')

-- -- nvim-telescope
-- map('n', '<leader>f', '<cmd>Telescope find_files<CR>')
-- map('n', '<leader>g', '<cmd>Telescope live_grep<CR>')
-- map('n', '<leader>b', '<cmd>Telescope buffers<CR>')
-- map('n', '<leader>h', '<cmd>help_tags<CR>')

-- fzf
map('n', '<leader>f', '<cmd>FzfLua files<CR>')
map('n', '<leader>g', '<cmd>FzfLua git_files<CR>')
map('n', '<leader>b', '<cmd>FzfLua buffers<CR>')
map('n', '<leader>h', '<cmd>FzfLua btags<CR>')
map('n', '<leader>a', '<cmd>FzfLua grep_project<CR>')

-- Trouble
map('n', '<space>cx', '<cmd>Trouble<CR>', { noremap=true, silent=true })
map('n', 'gR', '<cmd>TroubleToggle lsp_references<CR>', { noremap=true, silent=true })
map('n', 'gq', '<cmd>TroubleToggle document_diagnostics<CR>', { noremap=true, silent=true })
map('n', 'gqf', '<cmd>TroubleToggle quickfix<CR>', { noremap=true, silent=true })

-- LSP
map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts) -- press K once to open hover menu, press K again to move into it
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
map('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
map('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
map('n', '<space>Q', '<cmd>lua vim.diagnostic.open_float(0, {scope="line"})<CR>', opts)
map('n', '<space>q', '<cmd>lua vim.diagnostic.open_float(0, {scope="cursor"})<CR>', opts)

 


