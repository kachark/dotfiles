
M = {}

function M.setup()

  local dap = require('dap')
  local dapui = require('dapui')

  -- Ensure equal to paths declared in lsp.lua
  local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/'
  local codelldb_path = extension_path .. 'adapter/codelldb'
  local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'


  -- ADAPTERS
  -- Configured to use LLDB debugger for LLVM (C/C++/Rust)
  -- dap.adapters.lldb = {
  --   type = 'executable',
  --   command = '/opt/homebrew/Cellar/llvm/13.0.1_1/bin/lldb-vscode', -- adjust as needed, must be absolute path
  --   name = 'lldb'
  -- }


  -- Configured to use CodeLLDB vscode extension (C/C++/Rust)
  -- NOTE: have to manually start the codelldb server at 127.0.0.1, port 13000

  -- -- manual connection to CodeLLDB server
  -- dap.adapters.codelldb = {
  --   type = 'server',
  --   host = '127.0.0.1',
  --   port = 13000, -- use the port printed out or specified with --port
  --   command = '~/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/adapter/codelldb', -- adjust as needed, must be absolute path
  --   name = 'codelldb'
  -- }

  dap.adapters.codelldb = {
    type = 'server',
    port = '13000',
    executable = {
      -- CHANGE THIS to your path!
      command = codelldb_path,
      args = {'--port', '13000'},
    }
  }

  -- CONFIGURATION

  dap.configurations.cpp = {
    {
      name = 'Launch file',
      -- type = 'lldb',
      type = 'codelldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},

      -- 💀
      -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
      --
      --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      --
      -- Otherwise you might get the following error:
      --
      --    Error on launch: Failed to attach to the target process
      --
      -- But you should be aware of the implications:
      -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
      -- runInTerminal = false,
    },
  }

  -- If you want to use this for C and C++, add something like this:

  dap.configurations.rust = dap.configurations.cpp
  dap.configurations.c = dap.configurations.cpp


  -- DAP UI
  dapui.setup()
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

end

return M
