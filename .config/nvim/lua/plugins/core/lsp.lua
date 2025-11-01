local M = {}

-- =============================================================
-- State & Utilities
-- =============================================================

local inlay_hints_enabled = true

local function toggle_inlay_hints()
  inlay_hints_enabled = not inlay_hints_enabled
  vim.lsp.inlay_hint.enable(inlay_hints_enabled)
  if inlay_hints_enabled then
    print("Inlay hints enabled")
  else
    print("Inlay hints disabled")
  end
end

local function toggle_signature_help()
  -- Close any existing floating windows first
  local closed = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" and config.focusable then
      vim.api.nvim_win_close(win, true)
      closed = true
    end
  end

  -- If we didn't close any window, open signature help
  if not closed then
    vim.lsp.buf.signature_help()
  end
end

_G.ToggleInlayHints = toggle_inlay_hints
_G.ToggleSigantureHelp = toggle_signature_help

-- =============================================================
-- LSP Handlers & Keymaps
-- =============================================================

local function setup_handlers()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
      border = "single",
      prompt_border = "single"
    }
  )
end

-- Set keymaps for all LSPs
local function setup_global_keymaps()
  local wk = require("which-key")
  wk.add({
    { "<leader>ih", "cmd>lua ToggleInlayHints()<cr>", desc = "Toggle LSP Inlay Hints" },
  }, {
    mode = { "n" }
  })
  wk.add({
    { "<C-s>", "cmd>lua ToggleSigantureHelp()<cr>", desc = "Toggle LSP Signature Help" },
  }, {
    mode = { "i" }
  })
end

local function on_attach(client, bufnr)
  vim.lsp.inlay_hint.enable(inlay_hints_enabled)
end

-- =============================================================
-- LSP-specific Autocommands
-- =============================================================

-- clangd specific
local function switch_source_header_vsplit()
  local params = { uri = vim.uri_from_bufnr(0) }
  vim.lsp.buf_request(0, 'textDocument/switchSourceHeader', params, function(err, result)
    if err then
      print("Error switching source/header: " .. err.message)
      return
    end
    if not result then
      print("Corresponding file not found")
      return
    end
    -- Open in vertical split
    vim.cmd('vsplit ' .. vim.uri_to_fname(result))
  end)
end

local function setup_lsp_autocommands()
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Clangd-specific keymaps
    if client and client.name == 'clangd' then
      local wk = require("which-key")
      wk.add({
        { "<leader>lb", "<cmd>LspClangdSwitchSourceHeader<cr>", desc = "Switch Between Source/Header" },
        { "<leader>lv", function() switch_source_header_vsplit() end, desc = "Open Source/Header (vsplit)" },
      }, {
        mode = { "n" },
        buffer = args.buf
      })
    end

    end,
  })
end

-- =============================================================
-- LSP Server Configuration
-- =============================================================

local function configure_servers(capabilities)

  -- Lua
  vim.lsp.config('lua_ls', {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- C/C++
  vim.lsp.config('clangd', {
    capabilities = capabilities,
    filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
  })

  -- Protobuf
  vim.lsp.config('protols', {})

  -- Python
  vim.lsp.config('basedpyright', {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- Javascript/Typescript
  vim.lsp.config('tsserver', {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- Svelte
  vim.lsp.config('svelte', {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- TailwindCSS
  vim.lsp.config('tailwindcss', {
    on_attach = on_attach,
    capabilities = capabilities,
  })

  -- Rust
  vim.lsp.config('rust_analyzer', {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ['rust-analyzer'] = {
        check = {
          command = "clippy",
          extraArgs = { "--all", "--", "-W", "clippy::all" },
        },
      }
    }
  })

  -- Rust using rustaceanvim
  local rustaceanvim_config = require('plugins.lang.rust')
  vim.g.rustaceanvim = rustaceanvim_config.get_config(capabilities)
end

-- =============================================================
-- Enable LSP Servers
-- =============================================================

local function enable_servers()
  local servers = {
    'lua_ls',
    'clangd',
    'protols',
    'basedpyright',
    'tsserver',
    'svelts',
    'tailwindcss',
    -- 'rust_analyzer',
  }

  for _, server in ipairs(servers) do
    vim.lsp.enable(server)
  end
end

-- =============================================================
-- Main Setup
-- =============================================================

function M.setup()
  -- Get capabilities from blink.cmp
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  setup_handlers()
  setup_global_keymaps()
  setup_lsp_autocommands()
  configure_servers(capabilities)
  enable_servers()
end

return M
