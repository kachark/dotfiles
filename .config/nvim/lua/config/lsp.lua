
-- plugin imports
local lsp = require('lspconfig')
local lspkind = require('lspkind')
local cmp = require('cmp')
local rt = require('rust-tools')
require('symbols-outline').setup()

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())


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

  formatting = {
    format = lspkind.cmp_format({
      with_text = false, -- do not show text alongside icons
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
        return vim_item
      end
    })
  },

}


-- LSP SETTINGS
function on_attach(client)

  -- functions
  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

--   -- lsp pictograms
--   -- commented options are defaults
--   lspkind.init({
--       -- with_text = true,
--       -- symbol_map = {
--       --   Text = '',
--       --   Method = 'ƒ',
--       --   Function = '',
--       --   Constructor = '',
--       --   Variable = '',
--       --   Class = '',
--       --   Interface = 'ﰮ',
--       --   Module = '',
--       --   Property = '',
--       --   Unit = '',
--       --   Value = '',
--       --   Enum = '了',
--       --   Keyword = '',
--       --   Snippet = '﬌',
--       --   Color = '',
--       --   File = '',
--       --   Folder = '',
--       --   EnumMember = '',
--       --   Constant = '',
--       --   Struct = ''
--       -- },
--   })

end


-- -- lsp specific settings --

-- C/C++
-- For ccls we use the default settings
lsp.ccls.setup {
  capabilities = capabilities,
}

-- Python
-- root_dir is where the LSP server will start: here at the project root otherwise in current folder
lsp.pyright.setup{
  on_attach=on_attach,
  capabilities = capabilities,
  root_dir = lsp.util.root_pattern('.git', vim.fn.getcwd())
}

-- Tex
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

-- Javascript/Typescript
lsp.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- TailwindCSS (Styling)
lsp.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities
})

-- Rust (rust-tools.nvim replaces rust LSP config - see below)
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


-- rust-tools.nvim config
local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

local opts = {

    -- defaults are auto populated and don't need to be specified unless making custom changes

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
      -- standalone file support
      -- setting it to false may improve startup time
      standalone = true,

      -- custom stuff
      on_attach=on_attach,
      capabilities = capabilities,

    }, -- rust-analyer options

    -- debugging stuff
    dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(
        codelldb_path, liblldb_path)
    }
}

rt.setup(opts)
