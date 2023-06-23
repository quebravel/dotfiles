-- Pull in the wezterm API
local wezterm = require 'wezterm';

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'GruvboxDarkHard'
config.window_background_opacity = 0.95
config.font = wezterm.font 'JetBrains Mono NF'
config.font_size = 9
config.freetype_load_target = "HorizontalLcd"
config.freetype_render_target = 'HorizontalLcd'
config.freetype_load_flags = 'FORCE_AUTOHINT'
config.line_height = 1.0
config.cell_width = 1.0
-- config.font_rasterizer = FreeType
-- config.text_background_opacity = 1.0
-- config.cursor_thickness = "0.1cell"
config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	}
-- config.initial_cols = 110
-- config.initial_rows = 25
-- config.inactive_pane_hsb = {
-- 		saturation = 1.0,
-- 		brightness = wezterm.GLOBAL.is_dark and 0.90 or 0.95,
-- }
-- config.cursor_blink_rate = 500
-- config.default_cursor_style = "SteadyBlock"
-- config.font_antialias = "Subpixel"

-- key bindings
-- config.keys = {
--   { key = 'Escape', mods = 'ALT', action = wezterm.action.ActivateCopyMode },
-- }
-----------------------------------------------
   -- tab bar
-- config.enable_tab_bar = true
-- config.hide_tab_bar_if_only_one_tab = false
-- config.use_fancy_tab_bar = false
-- config.tab_max_width = 30
-- config.show_tab_index_in_tab_bar = false
-- config.switch_to_last_active_tab_when_closing_tab = true

config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = true
config.tab_max_width = 25
config.hide_tab_bar_if_only_one_tab = true
window_decorations = "TITLE | RESIZE"


-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_lower_left_triangle

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local edge_background = '#0b0022'
    local background = '#1b1032'
    local foreground = '#808080'

    if tab.is_active then
      background = '#2b2042'
      foreground = '#c0c0c0'
    elseif hover then
      background = '#3b3052'
      foreground = '#909090'
    end

    local edge_foreground = background

    local title = tab_title(tab)

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    title = wezterm.truncate_right(title, max_width - 2)

    return {
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_LEFT_ARROW },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_RIGHT_ARROW },
    }
  end
)



config.colors = {
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    background = '#0b0022',

    -- The active tab is the one that has focus in the window
    active_tab = {
      -- The color of the background area for the tab
      bg_color = '#2b2042',
      -- The color of the text for the tab
      fg_color = '#c0c0c0',

      -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
      -- label shown for this tab.
      -- The default is "Normal"
      intensity = 'Normal',

      -- Specify whether you want "None", "Single" or "Double" underline for
      -- label shown for this tab.
      -- The default is "None"
      underline = 'None',

      -- Specify whether you want the text to be italic (true) or not (false)
      -- for this tab.  The default is false.
      italic = false,

      -- Specify whether you want the text to be rendered with strikethrough (true)
      -- or not for this tab.  The default is false.
      strikethrough = false,
    },

    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = '#1b1032',
      fg_color = '#808080',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },

    -- The new tab button that let you create new tabs
    new_tab = {
      bg_color = '#1b1032',
      fg_color = '#808080',

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab`.
    },

    -- You can configure some alternate styling when the mouse pointer
    -- moves over the new tab button
    new_tab_hover = {
      bg_color = '#3b3052',
      fg_color = '#909090',
      italic = true,

      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `new_tab_hover`.
    },
  },
}

----------------------------------------------
-- and finally, return the configuration to wezterm
return config
