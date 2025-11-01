
-- Rustaceanvim
local function get_config(capabilities)
  return {

    -- Plugin configuration
    -- tools = {},
    -- LSP configuration
    server = {
      on_attach = function(client, bufnr)

        -- you can also put keymaps in here
        local wk = require("which-key")
        wk.add({
          { "<leader>cR" , function() vim.cmd.RustLsp("codeAction") end, desc = "Code Action" },
          { "<leader>dr" , function() vim.cmd.RustLsp("debuggables") end, desc = "Code Debuggables" },
          { "<leader>ih" , "<cmd>lua ToggleInlayHints()<cr>", desc = "Toggle LSP Inlay Hints" },
        },
        {
          mode = { "n" }
        })
      end,
      capabilities = capabilities,
      settings = {
        -- rust-analyzer language server configuration
        ["rust-analyzer"] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
              enable = true,
            },
          },
          check = {
            command = "clippy",
            extraArgs = { "--all", "--", "-W", "clippy::all" },
          },

          -- Add clippy lints for Rust.
          checkOnSave = true,
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
end

return {
  get_config = get_config
}
