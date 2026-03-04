-- 'Capri Capychino'
-- Pull in the wezterm API

local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
local session_manager = require("wezterm-session-manager/session-manager")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.adjust_window_size_when_changing_font_size = false
config.automatically_reload_config = true
config.background = {
	{
		source = {
			-- File = "C:\\Users\\adamk\\OneDrive\\Desktop\\pics\\blue-purple-waves.png",
			File = "/home/adam/blue-waves.png",
		},
		width = "100%",
		height = "100%",
	},
}
config.color_scheme = "Pandora"
config.colors = {
	tab_bar = {
		active_tab = {
			fg_color = "#5E5E5B",
			bg_color = "#2E85FF",
		},
	},
}
config.default_cursor_style = "BlinkingBar"
-- config.default_domain = "WSL:Ubuntu"
config.enable_tab_bar = true
config.enable_scroll_bar = true
config.enable_wayland = true
config.font = wezterm.font("Fira Code")
config.font_size = 18.5
config.hide_tab_bar_if_only_one_tab = false
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.mouse_bindings = {
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}
config.pane_focus_follows_mouse = true
config.scrollback_lines = 5000
config.switch_to_last_active_tab_when_closing_tab = true
config.tab_bar_at_bottom = true
config.tab_max_width = 32
config.unix_domains = {
	{
		name = "unix",
	},
}
config.use_dead_keys = false
config.use_fancy_tab_bar = true
config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "TITLE | RESIZE"
config.window_padding = {
	left = 3,
	right = 3,
	top = 0,
	bottom = 0,
}
config.keys = {
	{
		key = "Enter",
		mods = "ALT",
		action = act.DisableDefaultAssignment,
	},
	{
		key = "[",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},
	{
		key = "w",
		mods = "LEADER",
		action = act.ShowTabNavigator,
	},
	{
		key = "c",
		mods = "LEADER",
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = ",",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	{
		key = "n",
		mods = "LEADER",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "p",
		mods = "LEADER",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "&",
		mods = "LEADER|SHIFT",
		action = act.CloseCurrentTab({ confirm = true }),
	},
	{
		-- |
		key = "|",
		mods = "LEADER|SHIFT",
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		-- -
		key = "-",
		mods = "LEADER",
		action = act.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = "h",
		mods = "CTRL",
		action = act({ EmitEvent = "move-left" }),
	},
	{
		key = "j",
		mods = "CTRL",
		action = act({ EmitEvent = "move-down" }),
	},
	{
		key = "k",
		mods = "CTRL",
		action = act({ EmitEvent = "move-up" }),
	},
	{
		key = "l",
		mods = "CTRL",
		action = act({ EmitEvent = "move-right" }),
	},
	{
		key = "h",
		mods = "ALT",
		action = act({ EmitEvent = "resize-left" }),
	},
	{
		key = "j",
		mods = "ALT",
		action = act({ EmitEvent = "resize-down" }),
	},
	{
		key = "k",
		mods = "ALT",
		action = act({ EmitEvent = "resize-up" }),
	},
	{
		key = "l",
		mods = "ALT",
		action = act({ EmitEvent = "resize-right" }),
	},
	{
		key = "x",
		mods = "LEADER",
		action = act.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "{",
		mods = "LEADER|SHIFT",
		action = act.PaneSelect({ mode = "SwapWithActiveKeepFocus" }),
	},
	{
		key = "z",
		mods = "LEADER",
		action = act.TogglePaneZoomState,
	},
	{
		key = "f",
		mods = "ALT",
		action = act.TogglePaneZoomState,
	},
	{
		key = ";",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Prev"),
	},
	{
		key = "o",
		mods = "LEADER",
		action = act.ActivatePaneDirection("Next"),
	},
	{
		key = "a",
		mods = "LEADER",
		action = act.AttachDomain("unix"),
	},
	{
		key = "d",
		mods = "LEADER",
		action = act.DetachDomain({ DomainName = "unix" }),
	},
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
	},
	{
		key = "$",
		mods = "LEADER|SHIFT",
		action = act.PromptInputLine({
			description = "Enter new name for session",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					mux.rename_workspace(window:mux_window():get_workspace(), line)
				end
			end),
		}),
	},
	{
		key = "s",
		mods = "LEADER|SHIFT",
		action = act({ EmitEvent = "save_session" }),
	},
	{
		key = "L",
		mods = "LEADER|SHIFT",
		action = act({ EmitEvent = "load_session" }),
	},
	{
		key = "R",
		mods = "LEADER|SHIFT",
		action = act({ EmitEvent = "restore_session" }),
	},
}

-- config.color_scheme = "PaperColor Dark (base16)"
-- config.color_scheme = "s3r0 modified (terminal.sexy)"
-- config.font = wezterm.font("Harrington", {weight="Bold", stretch="Normal", style="Normal"})
-- config.window_decorations = "TITLE | RESIZE"
-- config.window_padding = {
-- 	left = 0,
-- 	right = 0,
-- 	top = 0,
-- 	bottom = 0,
-- }
-- config.font = wezterm.font('Hack')
-- "#073642"
-- "#2E85FF"
-- "#D1B900"
-- "#5E5E5B"
-- "#2aa198"

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

wezterm.on("save_session", function(window)
	session_manager.save_state(window)
end)
wezterm.on("load_session", function(window)
	session_manager.load_state(window)
end)
wezterm.on("restore_session", function(window)
	session_manager.restore_state(window)
end)

local move_around = function(window, pane, direction_wez, direction_nvim)
	local result = os.execute(
		"env NVIM_LISTEN_ADDRESS=/tmp/nvim"
			.. pane:pane_id()
			.. " "
			.. wezterm.home_dir
			.. "/.local/bin/wezterm.nvim.navigator"
			.. " "
			.. direction_nvim
	)
	if result then
		window:perform_action(act({ SendString = "\x17" .. direction_nvim }), pane)
	else
		window:perform_action(act({ ActivatePaneDirection = direction_wez }), pane)
	end
end

wezterm.on("move-left", function(window, pane)
	move_around(window, pane, "Left", "h")
end)
wezterm.on("move-right", function(window, pane)
	move_around(window, pane, "Right", "l")
end)
wezterm.on("move-up", function(window, pane)
	move_around(window, pane, "Up", "k")
end)
wezterm.on("move-down", function(window, pane)
	move_around(window, pane, "Down", "j")
end)

local vim_resize = function(window, pane, direction_wez, direction_nvim)
	local result = os.execute(
		"env NVIM_LISTEN_ADDRESS=/tmp/nvim"
			.. pane:pane_id()
			.. " "
			.. wezterm.home_dir
			.. "/.local/bin/wezterm.nvim.navigator"
			.. " "
			.. direction_nvim
	)
	if result then
		window:perform_action(act({ SendString = "\x1b" .. direction_nvim }), pane)
	else
		window:perform_action(act({ ActivatePaneDirection = direction_wez }), pane)
	end
end

wezterm.on("resize-left", function(window, pane)
	vim_resize(window, pane, "Left", "h")
end)
wezterm.on("resize-right", function(window, pane)
	vim_resize(window, pane, "Right", "l")
end)
wezterm.on("resize-up", function(window, pane)
	vim_resize(window, pane, "Up", "k")
end)
wezterm.on("resize-down", function(window, pane)
	vim_resize(window, pane, "Down", "j")
end)

return config
