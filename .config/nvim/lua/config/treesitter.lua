
M = {}

--- TreeSitter ---
function M.setup()
  local treesitter = require 'nvim-treesitter.configs'
  treesitter.setup {
    ensure_installed = {
      "c",
      "cpp",
      "lua",
      "rust",
      "python",
      "css",
      "typescript",
      "javascript",
      "vim",
      "bash",
      "yaml",
      "json5",
    }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
    highlight = {
      enable = true,              -- false will disable the whole extension
      disable = { },  -- list of language that will be disabled
    },
  }

  treesitter.setup {
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { }, -- list of languages that will be disabled
    },
  }
end

return M

