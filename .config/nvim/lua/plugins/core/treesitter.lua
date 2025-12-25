
local M = {}

--- TreeSitter ---
function M.setup()
  local treesitter = require('nvim-treesitter')

  treesitter.install {
    "c",
    "cpp",
    "lua",
    "rust",
    "python",
    "svelte",
    "css",
    "typescript",
    "javascript",
    "vim",
    "bash",
    "yaml",
    "json5",
  }

  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      -- Enable parsing and start highlighting
      -- We use pcall so it fails silently if the parser isn't installed yet.
      local active = pcall(vim.treesitter.start, args.buf)
      if active then
        -- Indents
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end,
  })

end

return M

