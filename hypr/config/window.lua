hl.workspace_rule({ workspace = "1", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "5", monitor = "eDP-1" })
hl.workspace_rule({ workspace = "6", monitor = "desc:ViewSonic Corporation VX2780-4K-hd VP9193140917" })
hl.workspace_rule({ workspace = "7", monitor = "desc:ViewSonic Corporation VX2780-4K-hd VP9193140917" })
hl.workspace_rule({ workspace = "8", monitor = "desc:ViewSonic Corporation VX2780-4K-hd VP9193140917" })
hl.workspace_rule({ workspace = "9", monitor = "desc:ViewSonic Corporation VX2780-4K-hd VP9193140917" })

hl.window_rule({
  name = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false,
  },
  no_focus = true,
})

hl.window_rule({
  name = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move = { "20", "monitor_h-120" },
  float = true,
})

hl.window_rule({
  name = "render gl",
  match = { class = "ModernGL" },
  float = true,
})
