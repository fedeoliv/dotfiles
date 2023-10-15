local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- config.color_scheme = "Tokyo Night"
config.font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Regular", italic = false })
config.font_size = 15.0

config.colors = {
	foreground = "#bdc1c6",
	background = "#010b17",

	-- Overrides the cell background color when the current cell is occupied by the
	-- cursor and the cursor style is set to Block
	cursor_bg = "#52ad70",

	-- Overrides the text color when the current cell is occupied by the cursor
	cursor_fg = "#9ca1aa",
	-- Specifies the border color of the cursor when the cursor style is set to Block,
	-- or the color of the vertical or horizontal bar when the cursor style is set to
	-- Bar or Underline.
	cursor_border = "#52ad70",

	selection_fg = "#080808",
	selection_bg = "#b2ceee",

	-- The color of the scrollbar "thumb"; the portion that represents the current viewport
	-- scrollbar_thumb = "#222222",

	-- The color of the split lines between panes
	split = "#444444",

	ansi = {
		"#1d3b53",
		"#fc514e",
		"#a1cd5e",
		"#e3d18a",
		"#82aaff",
		"#c792ea",
		"#7fdbca",
		"#a1aab8",
	},
	brights = {
		"#7c8f8f",
		"#ff5874",
		"#21c7a8",
		"#ecc48d",
		"#82aaff",
		"#ae81ff",
		"#7fdbca",
		"#d6deeb",
	},

	-- Arbitrary colors of the palette in the range from 16 to 255
	-- indexed = { [136] = "#af8700" },

	-- Since: 20220319-142410-0fcdea07
	-- When the IME, a dead key or a leader key are being processed and are effectively
	-- holding input pending the result of input composition, change the cursor
	-- to this color to give a visual cue about the compose state.
	-- compose_cursor = "orange",

	-- Colors for copy_mode and quick_select
	-- available since: 20220807-113146-c2fee766
	-- In copy_mode, the color of the active text is:
	-- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
	-- 2. selection_* otherwise
	-- copy_mode_active_highlight_bg = { Color = "#000000" },
	-- use `AnsiColor` to specify one of the ansi color palette values
	-- (index 0-15) using one of the names "Black", "Maroon", "Green",
	--  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
	-- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
	-- copy_mode_active_highlight_fg = { AnsiColor = "Black" },
	-- copy_mode_inactive_highlight_bg = { Color = "#52ad70" },
	-- copy_mode_inactive_highlight_fg = { AnsiColor = "White" },
	--
	-- quick_select_label_bg = { Color = "peru" },
	-- quick_select_label_fg = { Color = "#ffffff" },
	-- quick_select_match_bg = { AnsiColor = "Navy" },
	-- quick_select_match_fg = { Color = "#ffffff" },
}

return config
