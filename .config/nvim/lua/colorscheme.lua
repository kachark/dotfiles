local M = {}

-- Register plugin colorschemes (and any custom configs) here:

-- Available colorschemes with their setup functions
local colorschemes = {
  catppuccin = function()
    local colors = require("catppuccin.palettes").get_palette()
    require("catppuccin").setup({
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
      color_overrides = {
        mocha = {
          rosewater = "#ffc9c9",
          flamingo = "#ff9f9a",
          pink = "#ffa9c9",
          mauve = "#df95cf",
          lavender = "#a990c9",
          red = "#ff6960",
          maroon = "#f98080",
          peach = "#f9905f",
          yellow = "#f9bd69",
          green = "#b0d080",
          teal = "#a0dfa0",
          sky = "#a0d0c0",
          sapphire = "#95b9d0",
          blue = "#89a0e0",
          text = "#e0d0b0",
          subtext1 = "#d5c4a1",
          subtext0 = "#bdae93",
          overlay2 = "#928374",
          overlay1 = "#7c6f64",
          overlay0 = "#665c54",
          surface2 = "#504844",
          surface1 = "#3a3634",
          surface0 = "#252525",
          base = "#1A1E18",
          mantle = "#0e0e0e",
          crust = "#080808",
        },
      }
    })
    vim.cmd.colorscheme("catppuccin")
    return colors
  end,

  ["gruvbox-baby"] = function()
    vim.cmd.colorscheme("gruvbox-baby")
    return {} -- gruvbox-baby doesn't expose colors easily
  end,

  ["tokyonight-night"] = function()
    vim.g.tokyonight_style = "night"
    vim.g.tokyonight_italic_functions = true
    local colors = require('tokyonight.colors').setup()
    vim.cmd.colorscheme("tokyonight-night")
    return colors
  end,

  ["kanagawa-wave"] = function()
    vim.cmd.colorscheme("kanagawa-wave")
    local colors = require('kanagawa.colors').setup()
    return colors.palette
  end,

  ["modus_vivendi"] = function()
    local colors = require('modus-themes.colors').setup()
    vim.cmd.colorscheme("modus_vivendi")
    return colors
  end,

  dracula = function()
    local colors = require("dracula").colors()
    vim.cmd.colorscheme("dracula")
    return colors
  end,
}

-- Current active colorscheme
local current_theme = "catppuccin" -- Default theme

-- Setup scrollbar colors to match active theme
local function setup_scrollbar(colors)
  if not colors or vim.tbl_isempty(colors) then
    -- Fallback setup if no colors available
    require('scrollbar').setup({})
    return
  end

  require('scrollbar').setup({
    handle = {
      color = colors.bg_highlight or colors.surface1 or "#3a3634",
    },
    marks = {
      Search = { color = colors.orange or colors.peach or "#f9905f" },
      Error = { color = colors.error or colors.red or "#ff6960" },
      Warn = { color = colors.warning or colors.yellow or "#f9bd69" },
      Info = { color = colors.info or colors.blue or "#89a0e0" },
      Hint = { color = colors.hint or colors.teal or "#a0dfa0" },
      Misc = { color = colors.purple or colors.mauve or "#df95cf" },
    }
  })
end

-- Apply a colorscheme
function M.set_colorscheme(name)
  local colors = {}
  
  if colorschemes[name] then
    -- Custom colorscheme with setup function
    colors = colorschemes[name]()
  else
    -- Try built-in colorscheme
    local ok = pcall(vim.cmd.colorscheme, name)
    if not ok then
      vim.notify("Colorscheme '" .. name .. "' not found", vim.log.levels.ERROR)
      return
    end
    -- For built-in themes, we don't have color access, so use fallback
    colors = {}
  end

  current_theme = name
  setup_scrollbar(colors)
  vim.notify("Switched to " .. name .. " theme", vim.log.levels.INFO)
end

-- Cycle through available colorschemes
function M.cycle_colorscheme()
  local themes = M.list_colorschemes()
  
  local current_index = 1
  for i, theme in ipairs(themes) do
    if theme == current_theme then
      current_index = i
      break
    end
  end
  
  local next_index = current_index % #themes + 1
  M.set_colorscheme(themes[next_index])
end

-- Get list of available colorschemes (custom + built-in)
function M.list_colorschemes()
  local custom_themes = vim.tbl_keys(colorschemes)
  
  -- Get built-in colorschemes
  local builtin_themes = vim.fn.getcompletion('', 'color')
  
  -- Combine and deduplicate
  local all_themes = {}
  local seen = {}
  
  -- Add custom themes first (they take priority)
  for _, theme in ipairs(custom_themes) do
    if not seen[theme] then
      table.insert(all_themes, theme)
      seen[theme] = true
    end
  end
  
  -- Add built-in themes
  for _, theme in ipairs(builtin_themes) do
    if not seen[theme] then
      table.insert(all_themes, theme)
      seen[theme] = true
    end
  end
  
  table.sort(all_themes)
  return all_themes
end


-- Setup with default theme
function M.setup()
  M.set_colorscheme(current_theme)
end



return M
