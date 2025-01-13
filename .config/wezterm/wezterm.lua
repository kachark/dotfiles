
-- Pull in the wezterm API
local wezterm = require 'wezterm';

-- Get colorscheme name depending on OS theme
function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Mocha"
  else
    -- return "Catppuccin Latte"
    return "Catppuccin Frappe"
    -- return "Catppuccin Macchiato"
    -- return "Catppuccin Mocha"
  end
end

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.max_fps = 120

-- https://github.com/wez/wezterm/issues/3774
config.freetype_load_flags = 'NO_HINTING'

-- config.font = wezterm.font("SF Mono")

-- config.font = wezterm.font("JetBrains Mono")

-- config.font = wezterm.font("Cascadia Code PL")
-- config.font = wezterm.font("FiraCode Nerd Font")
-- config.font = wezterm.font("CaskaydiaCove Nerd Font")
-- config.font = wezterm.font("Hack Nerd Font")

-- config.font_size = 12

config.font = wezterm.font("Monaspace Neon")
config.font_size = 12.0
config.harfbuzz_features = { 'calt', 'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'ss09', 'liga'}
config.font_rules = {
  {
    intensity = "Normal",
    italic = true,
    font = wezterm.font({
      family = 'Hack Nerd Font', 
      weight = "Regular",
      italic = true
    }),
  },
}


-- config.color_scheme = "Snazzy"
-- config.color_scheme = "Dracula (Official)"
-- config.color_scheme = "Poimandres"
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

-- config.hide_tab_bar_if_only_one_tab = true
config.force_reverse_video_cursor = true

-- and finally, return the configuration to wezterm
return config
