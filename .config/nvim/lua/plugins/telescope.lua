
local M = {}

function M.setup()
  --- Telescope ---
  local actions = require('telescope.actions')
  local telescope = require('telescope')

  telescope.setup({
    defaults = {
      layout_strategy = "vertical",
      -- layout_strategy = "flex",
      mappings = {
        -- ESC will exit telescope window on first hit
        i = {
          ["<esc>"] = actions.close,
        },
      },
    },

    pickers = {
      buffers = {
        -- achieve similar functionality to FZF buffer ordering
        ignore_current_buffer = true,
        sort_mru = true,
      },
    },

    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                        -- the default case_mode is "smart_case"
      }
    }
  })

  -- To get fzf loaded and working with telescope, you need to call
  -- load_extension, somewhere after setup function:
  telescope.load_extension('fzf')

end

return M
