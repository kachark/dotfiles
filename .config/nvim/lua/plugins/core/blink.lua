local M = {}

function M.setup()
  local blink = require('blink.cmp')

  -- We use pcall to ensure plugins don't crash if missing
  local has_lspkind, lspkind = pcall(require, "lspkind")
  local has_mini_icons, mini_icons = pcall(require, "mini.icons")

  -- Cache lspkind's symbol map locally if lspkind is available
  local lspkind_map = has_lspkind and lspkind.symbol_map or {}

  local opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      preset = 'super-tab',
      ["<C-y>"] = { "select_and_accept" },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    completion = {
      accept = {
        -- experimental auto-brackets support
        auto_brackets = {
          enabled = true,
        },
      },
      menu = {
        draw = {
          treesitter = { "lsp" },
          components = {
            kind_icon = {
              ellipsis = false,

              text = function(ctx)
                local icon = ctx.kind_icon

                -- Direct string comparison is faster than vim.tbl_contains
                -- If the item is path related (file, folder, etc.) use mini.icons
                if ctx.source_name == 'Path' then
                  if has_mini_icons then
                    local dev_icon, _, _ = mini_icons.get("file", ctx.label)
                    if dev_icon then icon = dev_icon end
                  end
                else
                  -- otherwise, try lspkind (methods, functions, etc.)
                  if lspkind_map[ctx.kind] then
                    icon = lspkind_map[ctx.kind]
                  elseif has_mini_icons then
                    -- Fallback to mini.icons
                    local mini_lsp_icon, _, _ = mini_icons.get("lsp", ctx.kind)
                    if mini_lsp_icon then icon = mini_lsp_icon end
                  end
                end

                return icon .. ctx.icon_gap
              end,

              -- Use mini.icons highlight groups
              highlight = function(ctx)
                local hl = "BlinkCmpKind" .. ctx.kind
                  or require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)

                if ctx.source_name == 'Path' then
                  local _, mini_hl, _ = mini_icons.get("file", ctx.label)
                  if mini_hl then hl = mini_hl end
                else
                  -- Fallback color if lspkind missing
                  if not lspkind_map[ctx.kind] and has_mini_icons then
                    local _, mini_hl, _ = mini_icons.get("lsp", ctx.kind)
                    if mini_hl then hl = mini_hl end
                  end
                end
                return hl
              end,
            }
          }
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      ghost_text = {
        enabled = vim.g.ai_cmp,
      },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- Disable cmdline completion
    cmdline = {
      enabled = false,
    }
  }

  blink.setup(opts)

end

return M
