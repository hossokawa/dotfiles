local wezterm = require("wezterm")
local act = wezterm.action

local keys = {
	{
		key = "g",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			local current_tab_id = pane:tab():tab_id()
			local cmd = "lazygit ; wezterm cli activate-tab --tab-id " .. current_tab_id .. " ; exit\n"
			local tab, tab_pane, _ = window:mux_window():spawn_tab({})
			tab_pane:send_text(cmd)
			tab:set_title(wezterm.nerdfonts.dev_git .. " Lazygit")
		end),
	},
	{
		key = "s",
		mods = "ALT",
		action = wezterm.action.SplitPane({
			direction = "Down",
		}),
	},
	{
		key = "v",
		mods = "ALT|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Right",
		}),
	},
	{
		key = "z",
		mods = "ALT",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "o",
		mods = "ALT",
		action = wezterm.action.ActivateLastTab,
	},
	{
		key = "t",
		mods = "ALT",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "r",
		mods = "LEADER",
		action = wezterm.action.ActivateKeyTable({
			name = "resize_pane",
			one_shot = false,
		}),
	},
	{ key = "L", mods = "CTRL|SHIFT|ALT", action = wezterm.action.ShowDebugOverlay },

	{ key = "h", mods = "ALT", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "ALT", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "ALT", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "ALT", action = act.ActivatePaneDirection("Right") },

	{ key = "UpArrow", mods = "SHIFT", action = act.ScrollToPrompt(-1) },
	{ key = "DownArrow", mods = "SHIFT", action = act.ScrollToPrompt(1) },
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			local tab, window = pane:move_to_new_tab()
		end),
	},
	{
		key = "N",
		mods = "LEADER | SHIFT",
		action = wezterm.action_callback(function(win, pane)
			local tab, window = pane:move_to_new_window()
		end),
	},
}

local function tab_switch_keys(key_table, modifier)
	for i = 1, 9 do
		table.insert(key_table, {
			key = tostring(i),
			mods = modifier,
			action = act.ActivateTab(i - 1),
		})
	end
	table.insert(key_table, {
		key = "0",
		mods = modifier,
		action = act.ActivateTab(9),
	})
	for i = 1, 9 do
		table.insert(keys, {
			key = tostring(i),
			mods = "CTRL|ALT",
			action = act.MoveTab(i - 1),
		})
	end
end

tab_switch_keys(keys, "ALT")

return keys
