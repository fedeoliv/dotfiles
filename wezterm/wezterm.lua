local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Catppuccin Mocha"

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.80
config.macos_window_background_blur = 30

-- config.font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Regular", italic = false })
-- config.font = wezterm.font("MonoLisaMedium Nerd Font", { weight = "Regular", italic = false })
config.font = wezterm.font("JetBrains Mono", { weight = "Medium", italic = false })

config.font_size = 13.0

config.enable_tab_bar = false

return config
