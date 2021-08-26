
-- plugin imports
local lsp = require('lspconfig')
-- local lspfuzzy = require('lspfuzzy')
-- local lspcompletion = require('completion')
local lsptrouble = require('trouble').setup{} -- error/warning description popup
local lspkind = require('lspkind')
local cmp = require('cmp')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

cmp.setup {
  snippet = {
    expand = function(args)
      -- You must install `vim-vsnip` if you use the following as-is.
      vim.fn['vsnip#anonymous'](args.body)
    end
  },

  -- You can set mapping if you want.
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- You should specify your *installed* sources.
  sources = {
    -- { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
  },
}


-- LSP SETTINGS
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
  lspkind.init({
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
  capabilities = capabilities,
  settings = {
        ["rust-analyzer"] = {
            assist = {
                -- importMergeBehavior = "last",
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
            -- checkOnSave = {
            --   command = "clippy"
            -- },
        }
    }
})
-- For ccls we use the default settings
lsp.ccls.setup {
  capabilities = capabilities,
}
-- root_dir is where the LSP server will start: here at the project root otherwise in current folder
lsp.pyright.setup {root_dir = lsp.util.root_pattern('.git', vim.fn.getcwd())}
lsp.pyright.setup{
  on_attach=on_attach,
  capabilities = capabilities,
}

lsp.texlab.setup({
  on_attach=on_attach,
  capabilities = capabilities,
  -- settings={
  --   cmd={"tectonic"}
  -- }
})

lsp.tsserver.setup({
  on_attach=on_attach,
  capabilities = capabilities,
})

-- lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list

