
-- plugin imports
local lsp = require('lspconfig')
local lspkind = require('lspkind')
local cmp = require('cmp')

require('rust-tools.inlay_hints').set_inlay_hints()
require('rust-tools').setup({})

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())


-- Configure cmp completion
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
    { name = 'path' },
  },
}


-- LSP SETTINGS
function on_attach(client)

  -- functions
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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


-- -- lsp specific settings --
-- -- lsp.rls.setup {}
-- -- lsp.rls.setup{on_attach=on_attach}
-- lsp.rust_analyzer.setup({
--   on_attach=on_attach,
--   capabilities = capabilities,
--   settings = {
--         ["rust-analyzer"] = {
--             assist = {
--                 -- importMergeBehavior = "last",
--                 importGranularity = "module",
--                 importPrefix = "by_self",
--             },
--             cargo = {
--                 loadOutDirsFromCheck = true
--             },
--             procMacro = {
--                 enable = true
--             },
--             checkOnSave = {
--               command = "clippy"
--             },
--         }
--     }
-- })

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
  cmd={"texlab"},
  filetypes = { "tex", "bib" },
  root_dir = function(fname)
        return lsp.util.root_pattern '.latexmkrc'(fname) or lsp.util.find_git_ancestor(fname)
      end,
  single_file_support = true,
  settings = {
    texlab = {
      auxDirectory = ".",
      bibtexFormatter = "texlab",
      formatterLineLength = 80,
      build = {
        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        executable = "latexmk",
        forwardSearchAfter = false,
        onSave = false
      },
      chktex = {
        onEdit = false,
        onOpenAndSave = false
      },
      diagnosticsDelay = 300,
      formatterLineLength = 80,
      forwardSearch = {
        args = {}
      },
      latexFormatter = "latexindent",
      latexindent = {
        modifyLineBreaks = false
      },
    }
  },
})

lsp.tsserver.setup({
on_attach=on_attach,
capabilities = capabilities,
})

-- lspfuzzy.setup {}  -- Make the LSP client use FZF instead of the quickfix list

