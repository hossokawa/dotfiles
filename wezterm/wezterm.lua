local wezterm = require("wezterm")

local config = {}

local function mergeTables(t1, t2)
	for key, value in pairs(t2) do
		t1[key] = value
	end
end

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

-- Appearance
config.color_scheme = "Tokyo Night Storm"
config.hide_tab_bar_if_only_one_tab = true
config.hide_mouse_cursor_when_typing = false
config.inactive_pane_hsb = {
    brightness = 0.9,
}
config.enable_scroll_bar = true

config.window_padding = {
  left = 5,
  right = 0,
  top = 5,
  bottom = 0,
}

local colors = require("colors")
mergeTables(config, colors)

-- Shell
config.default_prog = { "C:/Program Files/PowerShell/7/pwsh.exe", "-NoLogo" }
config.default_cwd = "E:/code"
-- config.default_domain = "WSL:Ubuntu-22.04"

-- Fonts
config.font = wezterm.font "GeistMono NF"
config.font_size = 14.0

-- Keybinds
config.leader = { key = "a", mods = "CTRL" }
config.keys = require("keybinds")
    
config.key_tables = {
    resize_pane = {
    { key = "LeftArrow", action = wezterm.action.AdjustPaneSize { "Left", 1 } },
    { key = "h", action = wezterm.action.AdjustPaneSize { "Left", 1 } },

    { key = "RightArrow", action = wezterm.action.AdjustPaneSize { "Right", 1 } },
    { key = "l", action = wezterm.action.AdjustPaneSize { "Right", 1 } },

    { key = "UpArrow", action = wezterm.action.AdjustPaneSize { "Up", 1 } },
    { key = "k", action = wezterm.action.AdjustPaneSize { "Up", 1 } },

    { key = "DownArrow", action = wezterm.action.AdjustPaneSize { "Down", 1 } },
    { key = "j", action = wezterm.action.AdjustPaneSize { "Down", 1 } },

    -- Cancel the mode by pressing escape
    { key = "Escape", action = "PopKeyTable" },
    }
}

config.scrollback_lines = 5000
config.window_close_confirmation = "NeverPrompt"

local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
resurrect.periodic_save()

local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")
workspace_switcher.workspace_formatter = function(label)
	return wezterm.format({
		{ Attribute = { Italic = true } },
		{ Foreground = { Color = colors.colors.ansi[3] } },
		{ Background = { Color = colors.colors.background } },
		{ Text = "󱂬 : " .. label },
	})
end

wezterm.on("smart_workspace_switcher.workspace_switcher.created", function(window, path, label)
	window:gui_window():set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = colors.colors.ansi[5] } },
		{ Text = basename(path) .. "  " },
	}))
	local workspace_state = resurrect.workspace_state

	workspace_state.restore_workspace(resurrect.load_state(label, "workspace"), {
		window = window,
		relative = true,
		restore_text = true,
		on_pane_restore = resurrect.tab_state.default_on_pane_restore,
	})
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.chosen", function(window, path, label)
	window:gui_window():set_right_status(wezterm.format({
		{ Attribute = { Intensity = "Bold" } },
		{ Foreground = { Color = colors.colors.ansi[5] } },
		{ Text = basename(path) .. "  " },
	}))
end)

wezterm.on("smart_workspace_switcher.workspace_switcher.selected", function(window, path, label)
	local workspace_state = resurrect.workspace_state
	resurrect.save_state(workspace_state.get_workspace_state())
end)

wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

return config