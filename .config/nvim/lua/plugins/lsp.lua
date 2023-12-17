
M = {}

function M.setup()

  -- plugin imports
  local lsp = require('lspconfig')
  local cmp = require('cmp')
  local rust_tools = require('rust-tools')
  local ts_tools = require('typescript-tools')
  require('symbols-outline').setup()

  -- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  local cmp_defaults = require("cmp.config.default")()


  -- Configure cmp completion
  cmp.setup {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },

    preselect = 'none',
    completion = {
        -- completeopt = 'menu,menuone,noinsert,noselect'
        completeopt = 'menu,menuone,noinsert'
    },

    -- You can set mapping if you want.
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<S-CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<C-CR>"] = function(fallback)
        cmp.abort()
        fallback()
      end,
    },

    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "path" },
    }, {
      { name = "buffer" },
    }),

    formatting = {
      -- Format using icons from my defaults.lua (derived from LazyVim)
      format = function(_, item)
        local icons = require('defaults').icons.kinds
        if icons[item.kind] then
          item.kind = icons[item.kind] .. item.kind
        end
        return item
      end,
    },

    sorting = cmp_defaults.sorting,

  }


  -- LSP SETTINGS
  function on_attach(client, bufnr)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = "single",
        prompt_border = "single"
      }
    )

  end


  -- -- lsp specific settings --

  -- C/C++
  lsp.clangd.setup{
    on_attach=on_attach,
    capabilities = capabilities,
    -- cmd = {
    --   "clangd",
    --   "--background-index",
    -- }
  }

  -- Python
  -- root_dir is where the LSP server will start: here at the project root otherwise in current folder
  lsp.pyright.setup{
    on_attach = on_attach,
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

  -- ts_tools.setup({
  --   on_attach = on_attach,
  --   capabilities = capabilities,
  --   settings = {
  --     -- spawn additional tsserver instance to calculate diagnostics on it
  --     separate_diagnostic_server = true,
  --     -- "change"|"insert_leave" determine when the client asks the server about diagnostic
  --     publish_diagnostic_on = "insert_leave",
  --     -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
  --     -- (see 💅 `styled-components` support section)
  --     tsserver_plugins = {},
  --     -- described below
  --     tsserver_format_options = {},
  --     tsserver_file_preferences = {},
  --   },
  -- })

  -- Svelte (Web Framework)
  lsp.svelte.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- TailwindCSS (Styling)
  lsp.tailwindcss.setup({
    on_attach = on_attach,
    capabilities = capabilities
  })

--   -- Rust (rust-tools.nvim replaces rust LSP config - see below)
--   lsp.rust_analyzer.setup({
--     on_attach=on_attach,
--     capabilities = capabilities,
--     -- commands to tell LSPConfig how to run rust-analyzer
--     cmd = {
--       "rustup", "run", "stable", "rust-analyzer",
--     },
--   })


  -- rust-tools.nvim config with nvim-dap configured
  local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/'
  local codelldb_path = extension_path .. 'adapter/codelldb'
  local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

  local rust_tools_opts = {

      -- defaults are auto populated and don't need to be specified unless making custom changes

      -- all the opts to send to nvim-lspconfig
      -- these override the defaults set by rust-tools.nvim
      -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
      server = {
        -- standalone file support
        -- setting it to false may improve startup time
        standalone = true,

        -- custom stuff
        on_attach= function(_, bufnr)
          -- Hover actions
          vim.keymap.set("n", "<C-space>", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>a", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
        end,
        capabilities = capabilities,

      }, -- rust-analyer options

      -- debugging stuff
      dap = {
          adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
      }
  }

  rust_tools.setup(rust_tools_opts)

end

return M
