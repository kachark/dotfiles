
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
  local lsp_signature = require('lsp_signature')

  -- Add additional LSP capabilities via blink.cmp completion engine
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  -- Handler for dynamic LSP configuration
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

    -- enable lsp_signature
    lsp_signature.on_attach({}, bufnr)

  end

  -- Static LSP configuration --

  -- Lua
  vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- C/C++
  vim.lsp.config('clangd', {
    capabilities = capabilities,
    on_attach = on_attach,
    -- cmd = {
    --   "clangd",
    --   "--background-index",
    -- }
  })

  -- Python
  -- root_dir is where the LSP server will start: here at the project root otherwise in current folder
  vim.lsp.config('pyright', {
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = lsp.util.root_pattern('.git', vim.fn.getcwd())
  })

  -- Tex
  vim.lsp.config('texlab', {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {"texlab"},
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
  vim.lsp.config('ts_ls', {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- Svelte
  vim.lsp.config('svelte', {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- TailwindCSS
  vim.lsp.config('tailwindcss', {
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- Rust using rustaceanvim
  local rustaceanvim_config = require('plugins.lang.rust')
  rustaceanvim_config.server.capabilities = capabilities
  vim.g.rustaceanvim = rustaceanvim_config

  -- Enable LSP servers
  vim.lsp.enable('lua_ls')
  vim.lsp.enable('clangd')
  vim.lsp.enable('pyright')
  vim.lsp.enable('texlab')
  vim.lsp.enable('ts_ls')
  vim.lsp.enable('svelte')
  vim.lsp.enable('tailwindcss')

end

return M
