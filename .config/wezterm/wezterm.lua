local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.enable_wayland = true

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 10.0
config.harfbuzz_features = { "calt=1", "clig=1", "liga=1" }

config.color_scheme = "rose-pine-moon"

config.enable_tab_bar = false
config.window_padding = { left = 4, right = 4, top = 4, bottom = 4 }

return config
