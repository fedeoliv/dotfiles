local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.automatically_reload_config = true
config.enable_tab_bar = false
config.default_cursor_style = "BlinkingBar"

config.max_fps = 240
config.animation_fps = 10

-- window
-- config.window_background_opacity = 0.95
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE" -- disable title bar without disabling the resiable border
config.macos_window_background_blur = 30
config.window_padding = {
  -- left = 3,
  -- right = 3,
  -- top = 25,
  -- bottom = 0,
}

local theme = require("colors/vague")
config.colors = theme.colors()

-- config.font = wezterm.font("MonoLisaMedium Nerd Font", { weight = "Regular", italic = false })
-- config.font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Regular", italic = false })
config.font = wezterm.font("JetBrains Mono", { weight = "Medium", italic = false })
config.font_size = 16.0

-- URLs in Markdown files are not handled properly by default
-- Source: https://github.com/wez/wezterm/issues/3803#issuecomment-1608954312
config.hyperlink_rules = {
  -- Matches: a URL in parens: (URL)
  {
    regex = "\\((\\w+://\\S+)\\)",
    format = "$1",
    highlight = 1,
  },
  -- Matches: a URL in brackets: [URL]
  {
    regex = "\\[(\\w+://\\S+)\\]",
    format = "$1",
    highlight = 1,
  },
  -- Matches: a URL in curly braces: {URL}
  {
    regex = "\\{(\\w+://\\S+)\\}",
    format = "$1",
    highlight = 1,
  },
  -- Matches: a URL in angle brackets: <URL>
  {
    regex = "<(\\w+://\\S+)>",
    format = "$1",
    highlight = 1,
  },
  -- Then handle URLs not wrapped in brackets
  {
    -- Before
    --regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
    --format = '$0',
    -- After
    regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
    format = "$1",
    highlight = 1,
  },
  -- implicit mailto link
  {
    regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
    format = "mailto:$0",
  },
}

return config
