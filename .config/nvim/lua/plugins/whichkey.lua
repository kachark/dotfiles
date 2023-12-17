
local M = {}

function M.setup()

  local wk = require("which-key")

  local opts = {
    mode = {'n', 'v'}, -- Normal mode, Visual mode
    prefix = "",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local presets = require("which-key.plugins.presets")

  local mappings = {
    ["<leader>"] = {
      ["<leader>"] = {
        name = "+Quick Commands",
        c = { "<cmd>noh<cr>", "Clear Highlights" },
        d = { "<cmd>bd<cr>", "Close Current Buffer" },
        y = { '"+y', "Yank To + Register" },
      },

      f = {
        name = "+Find",
        -- FZF
        -- f = { "<cmd>FzfLua files<cr>", "Find File" },
        -- g = { "<cmd>FzfLua git_files<cr>", "Find Git Files" },
        -- b = { "<cmd>FzfLua buffers<cr>", "Find Buffers" },
        -- h = { "<cmd>FzfLua btags<cr>", "Find Buffer Tags" },
        -- a = { "<cmd>FzfLua grep_project<cr>", "Grep Project" },
        -- s = { "<cmd>FzfLua lgrep_curbuf<cr>", "Grep Buffer" },

        -- Telescope
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        g = { "<cmd>Telescope git_files<cr>", "Find Git Files" },
        b = { "<cmd>Telescope buffers<cr>", "Find Buffers" },
        h = { "<cmd>Telescope current_buffer_tags<cr>", "Find Buffer Tags" },
        a = { "<cmd>Telescope live_grep<cr>", "Grep Project" },
        s = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Grep Buffer" },
      },

      l = {
        name = "+Language Server",
        -- Trouble
        r = { "<cmd>TroubleToggle lsp_references<cr>", "Show Symbol References" },

        -- NVIM-LSP
        d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Jump To Symbol Definition" },
        n = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename All References To Symbol" },
        s = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Display Symbol Information. Use Twice To Jump Into Window" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "List All Symbol Implementations" },
        h = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Display Symbol Signature Information" },
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Prompt For Code Actions" },

        -- Symbols-outline
        y = { "<cmd>SymbolsOutline<cr>", "Show Symbol Tree For Current Buffer" },
      },

      q = {
        name = "+Diagnostics",
        ["["] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Jump To Prev Diagnostic" },
        ["]"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Jump To Next Diagnostic" },
        q = { "<cmd>lua vim.diagnostic.open_float(0, {scope='cursor'})<cr>", "Show Diagnostics Under Cursor" },
        Q = { "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<cr>", "Show Diagnostics For Line" },

        -- Trouble
        d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
      },

      x = {
        name = "+Debug (Must Be Configured)",
        -- NVIM-DAP (Debugger)
        b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
        c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
        i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
        O = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
        r = { "<cmd>lua require'dap'.repl.open()<cr>", "Open REPL" },
        l = { "<cmd>lua require'dap'.run_last()<cr>", "Run Last" },
        u = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
      }

    },
  }

  wk.register(mappings, opts)

end

return M
