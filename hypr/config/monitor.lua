hl.monitor({
  output = "desc:AU Optronics 0xDE95",
  mode = "3840x2160@120",
  position = "0x0",
  scale = 1.875,
})

hl.monitor({
  output = "desc:Tianma Microelectronics Ltd. TL160MDMP01",
  mode = "3072x1920@165",
  position = "0x0",
  scale = 1.5,
})

-- mirror eDP-1
hl.monitor({
  output = "desc:Hisense Electric Co. Ltd. HDMI 0x00000001",
  mode = "1920x1080@60",
  position = "auto",
  scale = 1,
  mirror = "eDP-1",
})

hl.monitor({
  output = "desc:ViewSonic Corporation VX2780-4K-hd VP9193140917",
  mode = "3840x2160@60",
  position = "auto",
  scale = 1.5,
})
