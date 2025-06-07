
local inlay_hints_enabled = true
function ToggleInlayHints()
  inlay_hints_enabled = not inlay_hints_enabled
  vim.lsp.inlay_hint.enable(inlay_hints_enabled)
  if inlay_hints_enabled then
    print("Inlay hints enabled")
  else
    print("Inlay hints disabled")
  end
end

local M = {}

function M.setup()

  -- plugin imports
  local lsp = require('lspconfig')
  local ts_tools = require('typescript-tools')

  -- Add additional LSP capabilities via blink.cmp completion engine
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  -- LSP SETTINGS
  function on_attach(client, bufnr)
    vim.lsp.inlay_hint.enable(inlay_hints_enabled)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
        border = "single",
        prompt_border = "single"
      }
    )

    -- you can also put keymaps in here
    local wk = require("which-key")
    wk.add({
      { "<leader>ih" , "<cmd>lua ToggleInlayHints()<cr>", desc = "Toggle LSP Inlay Hints" },
    },
    {
      mode = { "n" }
    })

  end

  -- lsp specific settings --

  -- lua
  lsp.lua_ls.setup{}

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
  lsp.ts_ls.setup({
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

  -- -- Rust (This is the lspconfig barebones setup for Rust. Now using rustaceanvim instead)
  -- lsp.rust_analyzer.setup({
  --   on_attach=on_attach,
  --   capabilities = capabilities,
  --   -- Server-specific settings. See `:help lspconfig-setup`
  --   settings = {
  --     ["rust-analyzer"] = {
  --       cargo = {
  --         allFeatures = true,
  --       },
  --       imports = {
  --         group = {
  --           enable = false,
  --         },
  --       },
  --       completion = {
  --         postfix = {
  --           enable = false,
  --         },
  --       },
  --     },
  --   },
  --   -- commands to tell LSPConfig how to run rust-analyzer
  --   -- cmd = {
  --   --   "rustup", "run", "stable", "rust-analyzer",
  --   -- },
  -- })

  -- -- NOTE: temporary until rust-analyzer + neovim server cancelled error -32802 resolved
  -- -- https://github.com/neovim/neovim/issues/30985
  -- for _, method in ipairs({ 'textDocument/diagnostic', 'workspace/diagnostic' }) do
  --   local default_diagnostic_handler = vim.lsp.handlers[method]
  --   vim.lsp.handlers[method] = function(err, result, context, config)
  --       if err ~= nil and err.code == -32802 then
  --           return
  --       end
  --       return default_diagnostic_handler(err, result, context, config)
  --   end
  -- end

  -- -- Rust using rustaceanvim
  local rustaceanvim_config = require('plugins.lang.rust')
  rustaceanvim_config.server.capabilities = vim.lsp.protocol.make_client_capabilities();
  vim.g.rustaceanvim = rustaceanvim_config

end

return M
