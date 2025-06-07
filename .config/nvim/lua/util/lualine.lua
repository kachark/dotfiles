-- Lualine utility functions
-- Provides custom components and formatters for lualine statusline

local Util = require("util")

---@class util.lualine
local M = {}

-- Create a lualine component that shows blink.cmp source status
function M.blink_source(name, icon)
  local started = false
  
  local function status()
    if not package.loaded["blink.cmp"] then
      return
    end
    
    -- Check if blink.cmp is available and get source status
    local ok, blink = pcall(require, "blink.cmp")
    if not ok then
      return
    end
    
    -- For blink.cmp, we check if the source is in the enabled sources
    local config = require("blink.cmp.config")
    if config and config.sources and config.sources.default then
      for _, source in ipairs(config.sources.default) do
        if source == name then
          started = true
          return "ok"
        end
      end
    end
    
    return started and "error" or nil
  end

  local colors = {
    ok = Util.ui.fg("Special"),
    error = Util.ui.fg("DiagnosticError"),
    pending = Util.ui.fg("DiagnosticWarn"),
  }

  return {
    function()
      return icon or require("defaults").icons.kinds[name:sub(1, 1):upper() .. name:sub(2)]
    end,
    cond = function()
      return status() ~= nil
    end,
    color = function()
      return colors[status()] or colors.ok
    end,
  }
end

-- Format text with highlight group for lualine component
---@param component any Lualine component instance
---@param text string Text to format
---@param hl_group? string Highlight group name
---@return string Formatted text with highlight
function M.format(component, text, hl_group)
  if not hl_group then
    return text
  end
  ---@type table<string, string>
  component.hl_cache = component.hl_cache or {}
  local lualine_hl_group = component.hl_cache[hl_group]
  if not lualine_hl_group then
    local utils = require("lualine.utils.utils")
    lualine_hl_group = component:create_hl({ fg = utils.extract_highlight_colors(hl_group, "fg") }, "LV_" .. hl_group)
    component.hl_cache[hl_group] = lualine_hl_group
  end
  return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
end

-- Create a lualine component that shows a prettified file path
-- Shortens long paths and highlights modified files
---@param opts? {relative: "cwd"|"root", modified_hl: string?}
function M.pretty_path(opts)
  opts = vim.tbl_extend("force", {
    relative = "cwd",
    modified_hl = "Constant",
  }, opts or {})

  return function(self)
    local path = vim.fn.expand("%:p") --[[@as string]]

    if path == "" then
      return ""
    end
    local root = Util.root.get({ normalize = true })
    local cwd = Util.root.cwd()

    if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
      path = path:sub(#cwd + 2)
    else
      path = path:sub(#root + 2)
    end

    local sep = package.config:sub(1, 1)
    local parts = vim.split(path, "[\\/]")
    if #parts > 3 then
      parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
    end

    if opts.modified_hl and vim.bo.modified then
      parts[#parts] = M.format(self, parts[#parts], opts.modified_hl)
    end

    return table.concat(parts, sep)
  end
end

-- Create a lualine component that shows the project root directory
-- Displays different information based on relationship between cwd and root
---@param opts? {cwd:false, subdirectory: true, parent: true, other: true, icon?:string}
function M.root_dir(opts)
  opts = vim.tbl_extend("force", {
    cwd = false,
    subdirectory = true,
    parent = true,
    other = true,
    icon = "󱉭 ",
    color = Util.ui.fg("Special"),
  }, opts or {})

  local function get()
    local cwd = Util.root.cwd()
    local root = Util.root.get({ normalize = true })
    local name = vim.fs.basename(root)

    if root == cwd then
      -- root is cwd
      return opts.cwd and name
    elseif root:find(cwd, 1, true) == 1 then
      -- root is subdirectory of cwd
      return opts.subdirectory and name
    elseif cwd:find(root, 1, true) == 1 then
      -- root is parent directory of cwd
      return opts.parent and name
    else
      -- root and cwd are not related
      return opts.other and name
    end
  end

  return {
    function()
      return (opts.icon and opts.icon .. " ") .. get()
    end,
    cond = function()
      return type(get()) == "string"
    end,
    color = opts.color,
  }
end

return M
