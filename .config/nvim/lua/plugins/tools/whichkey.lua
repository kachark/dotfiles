
local M = {}

function M.setup()

  local wk = require("which-key")

  -- Setup Harpoon with extensions
  local harpoon = require('harpoon')
  harpoon:setup({
    settings = {
      save_on_toggle = false,
      sync_on_ui_close = false,
    }
  })
  
  local harpoon_extensions = require("harpoon.extensions")
  harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
  harpoon:extend(harpoon_extensions.builtins.navigate_with_number())

  local opts = {
    mode = {'n', 'v'}, -- Normal mode, Visual mode
    prefix = "",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    { "<leader><leader>", group = "+Quick Commands" },
    { "<leader><leader>c", "<cmd>noh<cr>", desc = "Clear Highlights"},
    { "<leader><leader>d", "<cmd>bd<cr>", desc = "Close Current Buffer"},
    { "<leader><leader>y", '"+y', desc = "Yank To + Register"},
    { "<leader><leader>y", '"+y', desc = "Yank To + Register", mode = "v"},

    { "<leader>f", group = "+Find" },
    -- -- FZF
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find File" },
    { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Git Files" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find Buffers" },
    { "<leader>fh", "<cmd>FzfLua btags<cr>", desc = "Find Buffer Tags" },
    -- { "<leader>fa", "<cmd>FzfLua grep_project<cr>", desc = "Grep Project" },
    { "<leader>fa", "<cmd>FzfLua live_grep_glob<cr>", desc = "Grep Project" },
    { "<leader>fs", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Grep Buffer" },
    { "<leader>fs", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Grep Buffer" },

    { "<leader>l", group = "+Language Server" },
    -- Trouble
    { "<leader>lr", "<cmd>Trouble lsp toggle focus=false win.position=right win.size.width=0.4<cr>", desc = "Show Symbol References" },
    { "<leader>ly", "<cmd>Trouble symbols toggle focus=false win.size.width=0.4<cr>", desc = "Show Symbol Tree For Current Buffer" },
    -- NVIM-LSP
    { "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Jump To Symbol Definition" },
    { "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename All References To Symbol" },
    { "<leader>ls", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Display Symbol Information. Use Twice To Jump Into Window" },
    { "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", desc = "List All Symbol Implementations" },
    { "<leader>lh", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Display Symbol Signature Information" },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Prompt For Code Actions" },

    { "<leader>q", group = "+Diagnostics" },
    { "<leader>q[", "<cmd>lua vim.diagnostic.goto_prev()<cr>", desc = "Jump To Prev Diagnostic" },
    { "<leader>q]", "<cmd>lua vim.diagnostic.goto_next()<cr>", desc = "Jump To Next Diagnostic" },
    { "<leader>qq", "<cmd>lua vim.diagnostic.open_float(0, {scope='cursor'})<cr>", desc = "Show Diagnostics Under Cursor" },
    { "<leader>qQ", "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<cr>", desc = "Show Diagnostics For Line" },
    -- -- Trouble
    { "<leader>qd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Document Diagnostics" },
    { "<leader>qD", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
    { "<leader>ql", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    { "<leader>qt", "<cmd>Trouble todo toggle<cr>", desc = "Todo" },
    { "<leader>qT", "<cmd>Trouble todo toggle filter={tag = {TODO, FIX, FIXME}}<cr>", desc = "Todo/Fix/Fixme" },

    { "<leader>x", group = "+Debug (Must Be Configured)" },
    -- NVIM-DAP (Debugger)
    { "<leader>xb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
    { "<leader>xc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue" },
    { "<leader>xo", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over" },
    { "<leader>xi", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into" },
    { "<leader>xO", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out" },
    { "<leader>xr", "<cmd>lua require'dap'.repl.open()<cr>", desc = "Open REPL" },
    { "<leader>xl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Run Last" },
    { "<leader>xu", "<cmd>lua require'dapui'.toggle()<cr>", desc = "Toggle UI" },

    { "<leader>.", group = "+MarkedBufs" },
    -- Harpoon
    { "<leader>.a", function() harpoon:list():add() end, desc = "Mark Buffer" },
    { "<leader>.f", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "List Marked Buffers" },
    { "<leader>.q", function() harpoon:list():select(1) end, desc = "Mark (1)" },
    { "<leader>.w", function() harpoon:list():select(2) end, desc = "Mark (2)" },
    { "<leader>.e", function() harpoon:list():select(3) end, desc = "Mark (3)" },
    { "<leader>.r", function() harpoon:list():select(4) end, desc = "Mark (4)" },
    { "<leader>.d", function() harpoon:list():next() end, desc = "Next Mark" },
    { "<leader>.s", function() harpoon:list():prev() end, desc = "Previous Mark" },

  }

  wk.add(mappings, opts)

end

return M
