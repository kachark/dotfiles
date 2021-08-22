
-- plugin imports
local lsp = require('lspconfig')
-- local lspfuzzy = require('lspfuzzy')
-- local lspcompletion = require('completion')
local lsptrouble = require('trouble').setup{} -- error/warning description popup

function on_attach(client)

  -- lspcompletion.on_attach() -- for completion_nvim

  -- functions
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '<space>cx', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>cx', '<cmd>LspTroubleToggle<CR>', { noremap=true, silent=true })

  -- lsp pictograms
  -- commented options are defaults
  require('lspkind').init({
      -- with_text = true,
      -- symbol_map = {
      --   Text = '',
      --   Method = 'ƒ',
      --   Function = '',
      --   Constructor = '',
      --   Variable = '',
      --   Class = '',
      --   Interface = 'ﰮ',
      --   Module = '',
      --   Property = '',
      --   Unit = '',
      --   Value = '',
      --   Enum = '了',
      --   Keyword = '',
      --   Snippet = '﬌',
      --   Color = '',
      --   File = '',
      --   Folder = '',
      --   EnumMember = '',
      --   Constant = '',
      --   Struct = ''
      -- },
  })

end


-- lsp specific settings --
-- lsp.rls.setup {}
-- lsp.rls.setup{on_attach=on_attach}
lsp.rust_analyzer.setup({
  on_attach=on_attach,
  settings = {
        ["rust-analyzer"] = {
            assist = {
                importMergeBehavior = "last",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})
-- For ccls we use the default settings
lsp.ccls.setup {}
-- root_dir is where the LSP server will start: here at the project root otherwise in current folder
lsp.pyright.setup {root_dir = lsp.util.root_pattern('.git', vim.fn.getcwd())}
lsp.pyright.setup{on_attach=on_attach}

lsp.texlab.setup({
  on_attach=on_attach,
  -- settings={
  --   cmd={"tectonic"}
  -- }
})

lsp.tsserver.setup({
  on_attach=on_attach,
})

-- lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list



require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}
