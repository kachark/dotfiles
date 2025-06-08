local M = {}

function M.setup()
  --- Blink.cmp ---
  local blink = require('blink.cmp')

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  local opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      preset = 'enter',
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
                local lspkind = require("lspkind")
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local mini_icons = require("mini.icons")
                    local dev_icon, _, _ = mini_icons.get("file", ctx.label)
                    if dev_icon then
                        icon = dev_icon
                    end
                else
                    icon = require("lspkind").symbolic(ctx.kind, {
                        mode = "symbol",
                    })
                end

                return icon .. ctx.icon_gap
              end,

              -- Use mini.icons highlight groups
              highlight = function(ctx)
                local hl = "BlinkCmpKind" .. ctx.kind
                  or require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local mini_icons = require("mini.icons")
                  local _, mini_hl, _ = mini_icons.get("file", ctx.label)
                  if mini_hl then
                    hl = mini_hl
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
