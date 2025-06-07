local Util = require("util")

local M = {}

-- Lualine statusline configuration with custom components
-- uses utilities from /util
function M.setup()

  local lualine = require('lualine')

  local icons = require('defaults').icons

  local config = {
    options = {
      theme = "auto",
      globalstatus = true,
      disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch" },

      lualine_c = {
        Util.lualine.root_dir(),
        {
          "diagnostics",
          symbols = {
            error = icons.diagnostics.Error,
            warn = icons.diagnostics.Warn,
            info = icons.diagnostics.Info,
            hint = icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { Util.lualine.pretty_path() },
      },
      lualine_x = {
        -- stylua: ignore
        -- {
        --   function() return require("noice").api.status.command.get() end,
        --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
        --   color = Util.ui.fg("Statement"),
        -- },
        -- stylua: ignore
        -- {
        --   function() return require("noice").api.status.mode.get() end,
        --   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
        --   color = Util.ui.fg("Constant"),
        -- },
        -- stylua: ignore
        {
          function() return "  " .. require("dap").status() end,
          cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
          color = Util.ui.fg("Debug"),
        },
        -- {
        --   require("lazy.status").updates,
        --   cond = require("lazy.status").has_updates,
        --   color = Util.ui.fg("Special"),
        -- },
        {
          "diff",
          symbols = {
            added = icons.git.added,
            modified = icons.git.modified,
            removed = icons.git.removed,
          },
          source = function()
            local gitsigns = vim.b.gitsigns_status_dict
            if gitsigns then
              return {
                added = gitsigns.added,
                modified = gitsigns.changed,
                removed = gitsigns.removed,
              }
            end
          end,
        },
      },
      lualine_y = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      },
      lualine_z = {
        function()
          return " " .. os.date("%R")
        end,
      },
    },
    -- extensions = { "neo-tree", "lazy" },
    extensions = { "fzf" },
  }

  lualine.setup(config)
end

return M

--
-- function M.setup()
-- -- Eviline config for lualine
-- -- Author: shadmansaleh
-- -- Credit: glepnir
-- local lualine = require('lualine')
--
-- local icons = require('defaults').icons
--
-- -- Color table for highlights
-- -- stylua: ignore
-- local colors = {
--   bg       = '#202328',
--   fg       = '#bbc2cf',
--   yellow   = '#ECBE7B',
--   cyan     = '#008080',
--   darkblue = '#081633',
--   green    = '#98be65',
--   orange   = '#FF8800',
--   violet   = '#a9a1e1',
--   magenta  = '#c678dd',
--   blue     = '#51afef',
--   red      = '#ec5f67',
-- }
--
-- local conditions = {
--   buffer_not_empty = function()
--     return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
--   end,
--   hide_in_width = function()
--     return vim.fn.winwidth(0) > 80
--   end,
--   check_git_workspace = function()
--     local filepath = vim.fn.expand('%:p:h')
--     local gitdir = vim.fn.finddir('.git', filepath .. ';')
--     return gitdir and #gitdir > 0 and #gitdir < #filepath
--   end,
-- }
--
-- -- Config
-- local config = {
--   options = {
--     -- Disable sections and component separators
--     component_separators = '',
--     section_separators = '',
--     theme = {
--       -- We are going to use lualine_c an lualine_x as left and
--       -- right section. Both are highlighted by c theme .  So we
--       -- are just setting default looks o statusline
--       normal = { c = { fg = colors.fg, bg = colors.bg } },
--       inactive = { c = { fg = colors.fg, bg = colors.bg } },
--     },
--   },
--   sections = {
--     -- these are to remove the defaults
--     lualine_a = {},
--     lualine_b = {},
--     lualine_y = {},
--     lualine_z = {},
--     -- These will be filled later
--     lualine_c = {},
--     lualine_x = {},
--   },
--   inactive_sections = {
--     -- these are to remove the defaults
--     lualine_a = {},
--     lualine_b = {},
--     lualine_y = {},
--     lualine_z = {},
--     lualine_c = {},
--     lualine_x = {},
--   },
-- }
--
-- -- Inserts a component in lualine_c at left section
-- local function ins_left(component)
--   table.insert(config.sections.lualine_c, component)
-- end
--
-- -- Inserts a component in lualine_x at right section
-- local function ins_right(component)
--   table.insert(config.sections.lualine_x, component)
-- end
--
-- ins_left {
--   function()
--     return '▊'
--   end,
--   color = { fg = colors.blue }, -- Sets highlighting of component
--   padding = { left = 0, right = 1 }, -- We don't need space before this
-- }
--
-- ins_left {
--   -- mode component
--   function()
--     -- return ''
--     return icons.diagnostics.Error
--   end,
--   color = function()
--     -- auto change color according to neovims mode
--     local mode_color = {
--       n = colors.red,
--       i = colors.green,
--       v = colors.blue,
--       [''] = colors.blue,
--       V = colors.blue,
--       c = colors.magenta,
--       no = colors.red,
--       s = colors.orange,
--       S = colors.orange,
--       [''] = colors.orange,
--       ic = colors.yellow,
--       R = colors.violet,
--       Rv = colors.violet,
--       cv = colors.red,
--       ce = colors.red,
--       r = colors.cyan,
--       rm = colors.cyan,
--       ['r?'] = colors.cyan,
--       ['!'] = colors.red,
--       t = colors.red,
--     }
--     return { fg = mode_color[vim.fn.mode()] }
--   end,
--   padding = { right = 1 },
-- }
--
-- ins_left {
--   -- filesize component
--   'filesize',
--   cond = conditions.buffer_not_empty,
-- }
--
-- ins_left {
--   'filename',
--   cond = conditions.buffer_not_empty,
--   color = { fg = colors.magenta, gui = 'bold' },
-- }
--
-- ins_left { 'location' }
--
-- ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }
--
-- ins_left {
--   'diagnostics',
--   sources = { 'nvim_diagnostic' },
--   symbols = { error = ' ', warn = ' ', info = ' ' },
--   diagnostics_color = {
--     color_error = { fg = colors.red },
--     color_warn = { fg = colors.yellow },
--     color_info = { fg = colors.cyan },
--   },
-- }
--
-- -- Insert mid section. You can make any number of sections in neovim :)
-- -- for lualine it's any number greater then 2
-- ins_left {
--   function()
--     return '%='
--   end,
-- }
--
-- ins_left {}
-- -- ins_left {
-- --   -- Lsp server name .
-- --   function()
-- --     local msg = 'No Active Lsp'
-- --     local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
-- --     local clients = vim.lsp.get_active_clients()
-- --     if next(clients) == nil then
-- --       return msg
-- --     end
-- --     for _, client in ipairs(clients) do
-- --       local filetypes = client.config.filetypes
-- --       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
-- --         return client.name
-- --       end
-- --     end
-- --     return msg
-- --   end,
-- --   icon = ' LSP:',
-- --   color = { fg = '#ffffff', gui = 'bold' },
-- -- }
--
-- -- Add components to right sections
-- ins_right {
--   'o:encoding', -- option component same as &encoding in viml
--   fmt = string.upper, -- I'm not sure why it's upper case either ;)
--   cond = conditions.hide_in_width,
--   color = { fg = colors.green, gui = 'bold' },
-- }
--
-- ins_right {
--   'fileformat',
--   fmt = string.upper,
--   icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
--   color = { fg = colors.green, gui = 'bold' },
-- }
--
-- ins_right {
--   'branch',
--   icon = '',
--   color = { fg = colors.violet, gui = 'bold' },
-- }
--
-- ins_right {
--   -- 'diff',
--   -- -- Is it me or the symbol for modified us really weird
--   -- symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
--   -- diff_color = {
--   --   added = { fg = colors.green },
--   --   modified = { fg = colors.orange },
--   --   removed = { fg = colors.red },
--   -- },
--   -- cond = conditions.hide_in_width,
--
--   "diff",
--   symbols = {
--     added = icons.git.added,
--     modified = icons.git.modified,
--     removed = icons.git.removed,
--   },
--   source = function()
--     local gitsigns = vim.b.gitsigns_status_dict
--     if gitsigns then
--       return {
--         added = gitsigns.added,
--         modified = gitsigns.changed,
--         removed = gitsigns.removed,
--       }
--     end
--   end,
-- }
--
-- ins_right {
--   function()
--     return '▊'
--   end,
--   color = { fg = colors.blue },
--   padding = { left = 1 },
-- }
--
-- -- Now don't forget to initialize lualine
-- lualine.setup(config)

--
-- function M.setup()
--
--   -- Bubbles config for lualine
--   -- Author: lokesh-krishna
--   -- MIT license, see LICENSE for more details.
--
--   -- stylua: ignore
--   local colors = {
--     blue   = '#80a0ff',
--     cyan   = '#79dac8',
--     black  = '#080808',
--     white  = '#c6c6c6',
--     red    = '#ff5189',
--     violet = '#d183e8',
--     grey   = '#303030',
--   }
--
--   local bubbles_theme = {
--     normal = {
--       a = { fg = colors.black, bg = colors.violet },
--       b = { fg = colors.white, bg = colors.grey },
--       c = { fg = colors.black, bg = colors.black },
--     },
--
--     insert = { a = { fg = colors.black, bg = colors.blue } },
--     visual = { a = { fg = colors.black, bg = colors.cyan } },
--     replace = { a = { fg = colors.black, bg = colors.red } },
--
--     inactive = {
--       a = { fg = colors.white, bg = colors.black },
--       b = { fg = colors.white, bg = colors.black },
--       c = { fg = colors.black, bg = colors.black },
--     },
--   }
--
--   require('lualine').setup ({
--     options = {
--       -- theme = bubbles_theme,
--       -- theme = 'dracula',
--       theme = 'auto',
--       component_separators = '|',
--       section_separators = { left = '', right = '' },
--     },
--     sections= {
--       lualine_a = {
--         { 'mode', separator = { left = '' }, right_padding = 2 },
--       },
--       lualine_b = { 'filename', 'branch' },
--       lualine_c = { 'fileformat' },
--       lualine_x = {
--         {
--           'diagnostics',
--           source = { 'nvim' },
--           sections = { 'error' },
--           diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
--         },
--         {
--           'diagnostics',
--           source = { 'nvim' },
--           sections = { 'warn' },
--           diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
--         },
--       },
--       lualine_y = { 'filetype', 'progress' },
--       lualine_z = {
--         { 'location', separator = { right = '' }, left_padding = 2 },
--       },
--     },
--     inactive_sections = {
--       lualine_a = { 'filename' },
--       lualine_b = {},
--       lualine_c = {},
--       lualine_x = {},
--       lualine_y = {},
--       lualine_z = { 'location' },
--     },
--     tabline = {},
--     extensions = {},
--   })
--


  -- -- feline.nvim
  -- local vi_mode_utils = require 'feline.providers.vi_mode'

  -- local get_diag = function(str)
  --   local count = vim.lsp.diagnostic.get_count(0, str)
  --   return (count > 0) and ' '..count..' ' or ''
  -- end


  -- local vi_mode_component = {
  --   provider = function()
  --     local mode_alias = {
  --       n = 'NORMAL',
  --       no = 'NORMAL',
  --       i = 'INSERT',
  --       v = 'VISUAL',
  --       V = 'V-LINE',
  --       [''] = 'V-BLOCK',
  --       c = 'COMMAND',
  --       cv = 'COMMAND',
  --       ce = 'COMMAND',
  --       R = 'REPLACE',
  --       Rv = 'REPLACE',
  --       s = 'SELECT',
  --       S = 'SELECT',
  --       [''] = 'SELECT',
  --       t = 'TERMINAL',
  --     }
  --     return ' ' .. mode_alias[vim.fn.mode()] .. ' '
  --   end,
  --   hl = function()
  --     return {
  --       name = vi_mode_utils.get_mode_highlight_name(),
  --       fg = 'bg',
  --       bg = vi_mode_utils.get_mode_color(),
  --       style = 'bold',
  --     }
  --   end,
  --   right_sep = ' ',
  -- }

  -- require('feline').setup({
  --   colors = {
  --     fg = '#8FBCBB',
  --     bg = '#2E3440',
  --     black = '#434C5E',
  --     skyblue = '#81A1C1',
  --     cyan = '#88C0D0',
  --     green  = '#8FBCBB',
  --     oceanblue = '#5E81AC',
  --     magenta = '#B48EAD',
  --     orange = '#D08770',
  --     red = '#EC5F67',
  --     violet = '#B48EAD',
  --     white  = '#ECEFF4',
  --     yellow = '#EBCB8B',
  --   },
  --   vi_mode_colors = {
  --     NORMAL = 'cyan',
  --     OP = 'cyan',
  --     INSERT = 'white',
  --     VISUAL = 'green',
  --     BLOCK = 'green',
  --     REPLACE = 'yellow',
  --     ['V-REPLACE'] = 'yellow',
  --     ENTER = 'cyan',
  --     MORE = 'cyan',
  --     SELECT = 'magenta',
  --     COMMAND = 'cyan',
  --     SHELL = 'skyblue',
  --     TERM = 'skyblue',
  --     NONE = 'orange',
  --   },
  --   components = {
  --     left = {
  --       active = {
  --         vi_mode_component,
  --         { provider = 'git_branch' , icon = ' ', right_sep = '  ',
  --           enabled = function() return vim.b.gitsigns_status_dict ~= nil end },
  --         { provider = 'file_info' },
  --         { provider = '' , hl = { fg = 'bg', bg = 'black' }},
  --       },
  --       inactive = {
  --         vi_mode_component,
  --         { provider = 'git_branch' , icon = ' ', right_sep = '  ',
  --           enabled = function() return vim.b.gitsigns_status_dict ~= nil end },
  --         { provider = 'file_info' },
  --         { provider = '' , hl = { fg = 'bg', bg = 'black' }},
  --       }
  --     },
  --     mid = { active = {}, inactive = {} },
  --     right = {
  --       active = {
  --         { provider = function() return get_diag("Error") end,
  --           hl = { fg = 'bg', bg = 'red', style = 'bold' },
  --           left_sep = { str = '', hl = { fg = 'red', bg = 'black' }},
  --           right_sep = { str = '', hl = { fg = 'yellow', bg = 'red' }}},
  --         { provider = function() return get_diag("Warning") end,
  --           hl = { fg = 'bg', bg = 'yellow', style = 'bold'  },
  --           right_sep = { str = '', hl = { fg = 'cyan', bg = 'yellow' }}},
  --         { provider = function() return get_diag("Information") end,
  --           hl = { fg = 'bg', bg = 'cyan', style = 'bold' },
  --           right_sep = { str = '', hl = { fg = 'oceanblue', bg = 'cyan' }}},
  --         { provider = function() return get_diag("Hint") end,
  --           hl = { fg = 'bg', bg = 'oceanblue', style = 'bold' },
  --           right_sep = { str = '', hl = { fg = 'bg', bg = 'oceanblue', }}},
  --         { provider = 'file_encoding', left_sep = ' ' },
  --         { provider = 'position', left_sep = ' ', right_sep = ' ' },
  --         { provider = 'line_percentage',
  --           hl = { fg = 'bg', bg = 'skyblue', style = 'bold' },
  --           left_sep = { str = ' ', hl = { fg = 'bg', bg = 'skyblue' }},
  --           right_sep = { str = ' ', hl = { fg = 'bg', bg = 'skyblue' }}},
  --       },
  --       inactive = {}
  --     },
  --   },
  --   force_inactive = {
  --     filetypes = {
  --       'NvimTree',
  --       'packer',
  --       'dap-repl',
  --       'dapui_scopes', 'dapui_stacks', 'dapui_watches', 'dapui_repl',
  --       'LspTrouble',
  --     },
  --     buftypes = {'terminal'},
  --     bufnames = {},
  --   },
  -- })


  -- -- https://github.com/mnabila/nvimrc/blob/master/lua/plugins/galaxyline.lua

  -- local gl = require('galaxyline')
  -- local gls = gl.section
  -- local condition = require('galaxyline.condition')
  -- local vcs = require('galaxyline.provider_vcs')
  -- local buffer = require('galaxyline.provider_buffer')
  -- local fileinfo = require('galaxyline.provider_fileinfo')
  -- local diagnostic = require('galaxyline.provider_diagnostic')
  -- local lspclient = require('galaxyline.provider_lsp')
  -- local icons = require('galaxyline.provider_fileinfo').define_file_icon()

  -- local colors = {
  --     black     = '#282828',
  --     bblack    = '#928374',
  --     red       = '#cc241d',
  --     bred      = '#fb4934',
  --     green     = '#98971a',
  --     bgreen    = '#b8bb26',
  --     yellow    = '#d79921',
  --     byellow   = '#fabd2f',
  --     blue      = '#458588',
  --     bblue     = '#83a598',
  --     mangenta  = '#b16286',
  --     bmangenta = '#d3869b',
  --     cyan      = '#689d6a',
  --     bcyan     = '#8ec07c',
  --     white     = '#a89984',
  --     bwhite    = '#ebdbb2',
  -- }

  -- icons['man'] = {colors.green, ''}

  -- gls.left = {
  --     {
  --         Mode = {
  --             provider = function()
  --                local alias = {n = 'NORMAL', i = 'INSERT', c = 'COMMAND', V= 'VISUAL', [''] = 'VISUAL'}
  --                 if not condition.hide_in_width() then
  --                     alias = {n = 'N', i = 'I', c = 'C', V= 'V', [''] = 'V'}
  --                 end
  --                 return string.format('   %s ', alias[vim.fn.mode()])
  --             end,
  --             highlight = {colors.black, colors.yellow, 'bold'},
  --         }
  --     },
  --     {
  --         GitIcon = {
  --             provider = function() return '   ' end,
  --             condition = function() return condition.check_git_workspace() and condition.hide_in_width() end,
  --             highlight = {colors.black, colors.bblack}
  --         }
  --     },
  --     {
  --         GitBranch = {
  --             provider = function() return string.format('%s ', vcs.get_git_branch()) end,
  --             condition = function() return condition.check_git_workspace() and condition.hide_in_width() end,
  --             highlight = {colors.black, colors.bblack}
  --         }
  --     },
  --     {
  --         DiffAdd = {
  --             provider = vcs.diff_add,
  --             icon = '+',
  --             condition = function() return condition.check_git_workspace() and condition.hide_in_width() end,
  --             highlight = {colors.black, colors.bblack}
  --         }
  --     },
  --     {
  --         DiffModified = {
  --             provider = vcs.diff_modified,
  --             icon = '~',
  --             condition = function() return condition.check_git_workspace() and condition.hide_in_width() end,
  --             highlight = {colors.black, colors.bblack}
  --         }
  --     },
  --     {
  --         DiffRemove = {
  --             provider = vcs.diff_remove,
  --             icon = '-',
  --             condition = function() return condition.check_git_workspace() and condition.hide_in_width() end,
  --             highlight = {colors.black, colors.bblack}
  --         }
  --     },
  --     {
  --         BlankSpace = {
  --             provider = function() return ' ' end,
  --             highlight = {colors.black, colors.black}
  --         }
  --     },
  --     {
  --         FileIcon = {
  --             provider = fileinfo.get_file_icon,
  --             condition = condition.buffer_not_empty,
  --             highlight = {
  --                 fileinfo.get_file_icon_color,
  --                 colors.black
  --             },
  --         },
  --     },
  --     {
  --         FileName = {
  --             provider = function()
  --                 return string.format('%s| %s ', fileinfo.get_file_size(), fileinfo.get_current_file_name())
  --             end,
  --             condition = condition.buffer_not_empty,
  --             highlight = {colors.bwhite, colors.black}
  --         }
  --     },
  --     {
  --         Blank = {
  --             provider = function() return '' end,
  --             highlight = {colors.black, colors.black}

  --         }
  --     }
  -- }

  -- gls.right = {
  --     {
  --         DiagnosticError = {
  --             provider = diagnostic.get_diagnostic_error,
  --             icon = '  ',
  --             condition = function() return condition.check_active_lsp() and condition.hide_in_width() end,
  --             highlight = {colors.red, colors.black}
  --         },
  --     },
  --     {
  --         DiagnosticWarn = {
  --             provider = diagnostic.get_diagnostic_warn,
  --             icon = '  ',
  --             condition = function() return condition.check_active_lsp() and condition.hide_in_width() end,
  --             highlight = {colors.yellow, colors.black}
  --         },
  --     },
  --     {
  --         DiagnosticHint = {
  --             provider = diagnostic.get_diagnostic_hint,
  --             icon = '  ',
  --             condition = function() return condition.check_active_lsp() and condition.hide_in_width() end,
  --             highlight = {colors.cyan, colors.black}
  --         }
  --     },
  --     {
  --         DiagnosticInfo = {
  --             provider = diagnostic.get_diagnostic_info,
  --             icon = '  ',
  --             condition = function() return condition.check_active_lsp() and condition.hide_in_width() end,
  --             highlight = {colors.cyan, colors.black}
  --         }
  --     },
  --     {
  --         LspStatus = {
  --             provider = function() return string.format(' %s ', lspclient.get_lsp_client()) end,
  --             icon = '   ',
  --             condition = function() return condition.check_active_lsp() and condition.hide_in_width() end,
  --             highlight = {colors.white, colors.black}
  --         }
  --     },
  --     {
  --         FileType = {
  --             provider = function() return string.format(' %s ', buffer.get_buffer_filetype()) end,
  --             condition = function() return buffer.get_buffer_filetype() ~= '' end,
  --             highlight = {colors.white, colors.black}
  --         }
  --     },
  --     {
  --         FileFormat = {
  --             provider = function() return string.format('   %s ', fileinfo.get_file_format()) end,
  --             condition = condition.hide_in_width,
  --             highlight = {colors.black, colors.white}
  --         }
  --     },
  --     {
  --         FileEncode = {
  --             provider = function() return string.format('   %s ', fileinfo.get_file_encode()) end,
  --             condition = condition.hide_in_width,
  --             highlight = {colors.black, colors.bblack}
  --         }
  --     },
  --     {
  --         LineInfo = {
  --             provider = function() return string.format('   %s ', fileinfo.line_column()) end,
  --             highlight = {colors.black, colors.yellow}
  --         }
  --     },
  -- }

  -- gl.short_line_list = {'NvimTree'}
  -- gls.short_line_left = {
  --     {
  --         BufferIcon = {
  --             provider = function()
  --                 local icon = buffer.get_buffer_type_icon()
  --                 if icon ~= nil then
  --                     return string.format(' %s ', icon)
  --                 end
  --             end,
  --             highlight = {colors.white, colors.black}
  --         }
  --     },
  --     {
  --         BufferName = {
  --             provider = function()
  --                 if vim.fn.index(gl.short_line_list, vim.bo.filetype) ~= -1 then
  --                     local filetype = vim.bo.filetype
  --                     if filetype == 'NvimTree' then
  --                         return ' Explorer '
  --                     end
  --                 else
  --                     if fileinfo.get_current_file_name() ~= '' then
  --                         return string.format(' %s %s| %s ', fileinfo.get_file_icon(), fileinfo.get_file_size() , fileinfo.get_current_file_name())
  --                     end
  --                 end
  --             end,
  --             separator = '',
  --             highlight = {colors.white, colors.black}
  --         }
  --     }
  -- } 


  -- ---------------------------------------------------------------------------- }}}
  -- ---------------------------------------------------------------------------- }}}
  -- -- Force manual load so that nvim boots with a status line
  -- gl.load_galaxyline() 

-- end

-- return M

