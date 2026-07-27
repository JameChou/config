hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "altwin:swap_lalt_lwin,ctrl:swapcaps",
    kb_rules = "",
    follow_mouse = 1,
    sensitivity = 0,
    emulate_discrete_scroll = 0,
    touchpad = {
      scroll_factor = 0.6,
      natural_scroll = true,
      tap_to_click = true,
      tap_and_drag = true,
      drag_lock = true,
      disable_while_typing = true,
    },
  },
})

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})
