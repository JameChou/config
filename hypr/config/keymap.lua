local terminal = "kitty"
local fileManager = "dolphin"
local menu = "rofi"
local mainMod = "SUPER"

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- hl.dsp.window.kill() -> force killing the session of window
hl.bind(mainMod .. " + CONTROL + Q", hl.dsp.window.kill())
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.workspace.toggle_special("special"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special:special", follow = false }))
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show drun -icon-theme 'Papirus' -show-icons"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("rofi -show window -icon-theme 'Papirus' -show-icons"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("fcitx5-remote -t"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "d" }))

hl.bind(mainMod .. " + CONTROL + H", hl.dsp.window.swap({ direction = "l" }))
hl.bind(mainMod .. " + CONTROL + L", hl.dsp.window.swap({ direction = "r" }))
hl.bind(mainMod .. " + CONTROL + J", hl.dsp.window.swap({ direction = "d" }))
hl.bind(mainMod .. " + CONTROL + K", hl.dsp.window.swap({ direction = "u" }))

hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("killall waybar || waybar"))

hl.bind(mainMod .. " + CONTROL + mouse_down",
  hl.dsp.exec_cmd(
    [[hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') + 0.5}")]]))
hl.bind(mainMod .. " + CONTROL + mouse_up",
  hl.dsp.exec_cmd(
    [[hyprctl keyword cursor:zoom_factor $(awk "BEGIN {print $(hyprctl getoption cursor:zoom_factor | grep 'float:' | awk '{print $2}') - 0.5}")]]))

hl.bind(mainMod .. " + comma", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "m+1" }))

hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.window.move({ into_group = "l" }))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.window.move({ into_group = "r" }))

hl.bind(mainMod .. " + CONTROL + comma", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + CONTROL + period", hl.dsp.focus({ monitor = "-1" }))

hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("slurp | grim -g -"))
hl.bind(mainMod .. " + CONTROL + SHIFT + P", hl.dsp.exec_cmd("slurp | grim -g - - | wl-copy"))

for i = 1, 9 do
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = tostring(i) }))
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i), follow = false }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = "10" }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = "10", follow = false }))

hl.bind(mainMod .. " + Y", hl.dsp.window.resize({ x = -30, y = 30, relative = true }))
hl.bind(mainMod .. " + O", hl.dsp.window.resize({ x = 30, y = -30, relative = true }))
hl.bind(mainMod .. " + U", hl.dsp.window.resize({ x = -30, y = 30, relative = true }))
hl.bind(mainMod .. " + I", hl.dsp.window.resize({ x = 30, y = -30, relative = true }))
hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.window.resize({ x = -10, y = 10, relative = true }))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.resize({ x = 10, y = -10, relative = true }))
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.window.resize({ x = -10, y = 10, relative = true }))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.window.resize({ x = 10, y = -10, relative = true }))

hl.bind(mainMod .. " + backslash",
  hl.dsp.exec_cmd("hyprctl keyword 'device[elan0753:00-04f3:31c2-touchpad]:enabled' false"))
hl.bind(mainMod .. " + SHIFT + backslash",
  hl.dsp.exec_cmd("hyprctl keyword 'device[elan0753:00-04f3:31c2-touchpad]:enabled' true"))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5

---@param offset number
---@return nil
local function zoom(offset)
  local current = hl.get_config("cursor.zoom_factor")
  if offset ~= nil then
    current = current + offset
  elseif current ~= MIN_ZOOM then
    current = MIN_ZOOM
  else
    current = ZOOM_TOGGLE_FACTOR
  end
  current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
  hl.config({ cursor = { zoom_factor = current } })
end

hl.bind(mainMod .. " + Z", zoom)
hl.bind(mainMod .. " + equal", function()
  zoom(0.5)
end)
hl.bind(mainMod .. " + minus", function()
  zoom(-0.5)
end)

-- workspace rule
hl.bind(mainMod .. " + CONTROL + S", function()
  local workspace = hl.get_active_workspace()
  if hl.get_active_special_workspace() then
    workspace = hl.get_active_special_workspace()
  end

  if workspace.special then
    hl.workspace_rule({ workspace = tostring(workspace.name), layout = "scrolling" })
  else
    hl.workspace_rule({ workspace = tostring(workspace.id), layout = "scrolling" })
  end
end)


hl.bind(mainMod .. " + CONTROL + D", function()
  local workspace = hl.get_active_workspace()
  if hl.get_active_special_workspace() then
    workspace = hl.get_active_special_workspace()
  end

  if workspace.special then
    hl.workspace_rule({ workspace = tostring(workspace.name), layout = "dwindle" })
  else
    hl.workspace_rule({ workspace = tostring(workspace.id), layout = "dwindle" })
  end
end)
