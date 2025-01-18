local wezterm = require("wezterm")

local config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_decorations = "RESIZE",
	window_close_confirmation = "NeverPrompt",
	font_size = 16,
	color_scheme = "Catppuccin Mocha",
	font = wezterm.font("JetBrains Mono", { weight = "Medium" }),
}

config.keys = {
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.SendString("clear\n"),
	},
}

return config
