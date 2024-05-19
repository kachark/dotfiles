
-- Rustaceanvim
return {

  -- Plugin configuration
  -- tools = {},
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)

      -- you can also put keymaps in here
      local wk = require("which-key")
      wk.register({
        ["<leader>cR"] = { function() vim.cmd.RustLsp("codeAction") end, "Code Action" },
        ["<leader>dr"] = { function() vim.cmd.RustLsp("debuggables") end, "Code Debuggables" },
      }, { mode = "n", buffer = bufnr })
    end,
    settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        -- Add clippy lints for Rust.
        checkOnSave = {
          allFeatures = true,
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
        procMacro = {
          enable = true,
          ignored = {
            ["async-trait"] = { "async-trait" },
            ["napi-derive"] = { "napi" },
            ["async-recursion"] = { "async_recursion" },
          },
        },
      },
    },
  },
  -- DAP configuration
  -- dap = {
  -- },

}
