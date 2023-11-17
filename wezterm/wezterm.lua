local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"
config.window_decorations = "RESIZE"

config.font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Regular", italic = false })
config.font_size = 15.0

config.enable_tab_bar = false

return config
