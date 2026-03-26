local wezterm = require 'wezterm'
local act = wezterm.action
local config = {}

config.color_scheme = 'Dracula'
config.window_background_opacity = 0.9
config.font = wezterm.font 'JetBrains Mono NF'
config.font_size = 10
-- config.freetype_load_target = "HorizontalLcd"
-- config.freetype_render_target = 'HorizontalLcd'
-- config.freetype_load_flags = 'FORCE_AUTOHINT'
-- config.line_height = 1.0
-- config.cell_width = 1.0
-- config.font_rasterizer = FreeType
-- config.text_background_opacity = 1.0
-- config.cursor_thickness = "0.1cell"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0, }
config.enable_wayland = true


config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = true
config.tab_max_width = 25
config.hide_tab_bar_if_only_one_tab = true
window_decorations = "TITLE | RESIZE"

config.keys = {
  { key = 'Escape', mods = 'ALT', action = wezterm.action.ActivateCopyMode },
  { key = 'K', mods = 'CTRL|SHIFT', action = act.ScrollByLine(-1) },
  { key = 'J', mods = 'CTRL|SHIFT', action = act.ScrollByLine(1) },
}

return config
