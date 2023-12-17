
local M = {}

function M.setup()
  -- catppuccin.nvim
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

    -- darker for mocha
    -- https://github.com/catppuccin/nvim/discussions/323#discussioncomment-6410765
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
        base = "#151515",
        mantle = "#0e0e0e",
        crust = "#080808",
      },
    }
  })
  -- vim.cmd.colorscheme "catppuccin"
  vim.cmd.colorscheme "catppuccin-mocha"

  -- vim.cmd.colorscheme "gruvbox-baby"

  -- -- -- Dracula
  -- local dracula = require("dracula")
  -- local colors = require("dracula").colors()
  -- vim.cmd[[colorscheme dracula]]

  -- -- -- tokyonight
  -- vim.g.tokyonight_style = "night"
  -- vim.g.tokyonight_italic_functions = true
  -- local colors = require('tokyonight.colors').setup()
  -- vim.cmd 'colorscheme tokyonight'

  -- -- -- nightfox
  -- local nightfox = require('nightfox')
  -- vim.cmd 'colorscheme duskfox'
  -- local colors = require('nightfox.palette').load()


  -- vim.cmd 'colorscheme kanagawa-wave'
  -- local colors = require('kanagawa.colors').setup()
  -- local palette_colors = colors.palette
  -- local theme_colors = colors.theme


  -- nvim-scrollbar colors to match colorscheme
  require('scrollbar').setup({
      handle = {
          color = colors.bg_highlight,
      },
      marks = {
          Search = { color = colors.orange },
          Error = { color = colors.error },
          Warn = { color = colors.warning },
          Info = { color = colors.info },
          Hint = { color = colors.hint },
          Misc = { color = colors.purple },
      }
  })

end

return M
