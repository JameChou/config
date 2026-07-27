hl.monitor({
  output = "eDP-1",
  mode = "3840x2160@120",
  position = "0x0",
  scale = 1.875,
})

hl.monitor({
  output = "HDMI-A-2",
  mode = "1920x1080@60",
  position = "auto",
  scale = 1,
  mirror = "eDP-1",
})
