hl.config({
  input = {
    kb_layout  = "dk",
    kb_variant = "nodeadkeys",
    kb_model   = "",
    kb_options = "compose:rctrl",
    kb_rules   = "",
    numlock_by_default = true,
    repeat_rate = 25,
    repeat_delay = 300,
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
      natural_scroll = false,
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})

hl.device({
  name        = "epic-mouse-v1",
  sensitivity = -0.5,
})
