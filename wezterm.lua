local wezterm = require 'wezterm'
 
-- Set up default shell/domain to start
local wsl_domains = wezterm.default_wsl_domains()
 
for idx, dom in ipairs(wsl_domains) do
        dom.default_cwd = "~"
end
 
local act = wezterm.action
local mykeys = {
  { key = "o", mods = "LEADER|CTRL", action = act.ActivateLastTab },
  { key = "n", mods = "LEADER|CTRL", action = act.ActivateTabRelative(1) },
  { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "p", mods = "LEADER|CTRL", action = act.ActivateTabRelative(-1) },
  { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "0", mods = "LEADER", action = act.ActivateTab(9) }
}

for i = 1, 9 do
  -- leader + number to activate that tab
  table.insert(mykeys, {
    key = tostring(i),
    mods = 'LEADER',
    action = act.ActivateTab(i - 1),
  })
end

local mymouse = {
}

local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})

  for i = 0, 8 do
    window:spawn_tab { cwd = "/home/casret" }
  end
  act.ActivateTab(0)
end)

local config = {
  leader = { key = "o", mods = "CTRL" },
  wsl_domains = wsl_domains,
  audible_bell = "Disabled",
  default_domain = "WSL:Ubuntu",
  --default_prog = { 'C:\\Program Files\\Powershell\\7\\pwsh.exe' },
  font_size = 12,
  color_scheme = "Solarized Light (base16)",
  keys = mykeys,
  mouse_bindings = mymouse,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  tab_max_width = 200,
  font = wezterm.font("CaskaydiaCove NF"),
}
return config
