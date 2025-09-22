local wezterm = require("wezterm")
local config = wezterm.config_builder()

local function mergeTables(t1, t2)
	for key, value in pairs(t2) do
		t1[key] = value
	end
end

-- Appearance
config.max_fps = 144
config.color_scheme = "Tokyo Night Storm"
config.hide_tab_bar_if_only_one_tab = true
config.show_tab_index_in_tab_bar = false
config.hide_mouse_cursor_when_typing = false
config.inactive_pane_hsb = {
	brightness = 0.9,
}
config.enable_scroll_bar = true

config.window_padding = {
	left = 5,
	right = 0,
	top = 0,
	bottom = 0,
}

local colors = require("colors")
mergeTables(config, colors)

-- Shell
config.default_prog = { "C:/Program Files/PowerShell/7/pwsh.exe", "-NoLogo" }
-- config.default_cwd = "E:/code"
-- config.default_domain = "WSL:Ubuntu-24.04"

-- Fonts
config.font = wezterm.font("JetBrainsMono NF")
config.font_size = 12.0
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- Keybinds
config.leader = { key = "Space", mods = "CTRL" }
config.keys = require("keybinds")

config.key_tables = {
	resize_pane = {
		{ key = "LeftArrow", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },
		{ key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 1 }) },

		{ key = "RightArrow", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },
		{ key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 1 }) },

		{ key = "UpArrow", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },
		{ key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 1 }) },

		{ key = "DownArrow", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },
		{ key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 1 }) },

		-- Cancel the mode by pressing escape
		{ key = "Escape", action = "PopKeyTable" },
	},
}

config.scrollback_lines = 5000
config.window_close_confirmation = "NeverPrompt"

wezterm.on("gui-startup", function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

return config
