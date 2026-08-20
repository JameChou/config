hl.config({
  animations = {
    enabled = true
  },
})

hl.curve("snappy", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1 } } })      -- 打开/移动，几乎零延迟起步
hl.curve("snappy_out", { type = "bezier", points = { { 0.25, 0.7 }, { 0.35, 1 } } }) -- 关闭/淡出，同样立即响应

-- 窗口打开/移动/关闭
hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "snappy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 1.8, bezier = "snappy", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.5, bezier = "snappy_out", style = "popin 85%" })

-- 淡入淡出
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "snappy" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.8, bezier = "snappy" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.5, bezier = "snappy_out" })

-- 图层（rofi、wlogout 等）
hl.animation({ leaf = "layers", enabled = true, speed = 2, bezier = "snappy" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 2, bezier = "snappy", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "snappy_out" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.8, bezier = "snappy" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.5, bezier = "snappy_out" })

-- 其他
hl.animation({ leaf = "border", enabled = true, speed = 3, bezier = "snappy" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 4, bezier = "snappy" })

-- workspace 切换：不要动画，切过去就是切过去
-- enabled = false 时 speed/bezier 不起作用，随便填
hl.animation({ leaf = "workspaces", enabled = false, speed = 1, bezier = "snappy", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = false, speed = 1, bezier = "snappy", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = false, speed = 1, bezier = "snappy", style = "fade" })

-- scratchpad 不算 workspace 切换，保留一个快速的纵向滑入
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2, bezier = "snappy", style = "slidevert" })
