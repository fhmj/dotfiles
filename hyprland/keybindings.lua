local mainMod = "SUPER"
local altMod = "SUPER + SHIFT"

-- Shutdown, Reboot, Suspend, Logout
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("~/.local/share/quickshell-lockscreen/lock.sh"))
hl.bind(altMod .. " + Escape", hl.dsp.exec_cmd("systemctl poweroff"))
hl.bind(altMod .. " + Z", hl.dsp.exec_cmd("systemctl suspend"))
hl.bind(altMod .. " + R", hl.dsp.exec_cmd("systemctl reboot"))
hl.bind(altMod .. " + Q", hl.dsp.exec_cmd(
  "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
))

-- Refresh config
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.local/bin/refresh-config"))

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(altMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(altMod .. " + G", hl.dsp.layout("togglesplit"))    -- dwindle only

hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind(mainMod .. " + O", hl.dsp.group.prev())
hl.bind(mainMod .. " + P", hl.dsp.group.next())

-- Navigation
hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab", hl.dsp.focus({ last = true }));
hl.bind("ALT + onehalf", hl.dsp.focus({ workspace = "previous" }))

-- Moving windows
hl.bind(altMod .. " + H",  hl.dsp.window.move({ direction = "left" }))
hl.bind(altMod .. " + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(altMod .. " + K",    hl.dsp.window.move({ direction = "up" }))
hl.bind(altMod .. " + J",  hl.dsp.window.move({ direction = "down" }))

-- Media control
hl.bind("CTRL + SHIFT + SPACE",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("CTRL + SHIFT + Q",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
hl.bind("CTRL + SHIFT + W",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("CTRL + SHIFT + A",  hl.dsp.exec_cmd("playerctl volume 0.1-"),   { locked = true, repeating = true })
hl.bind("CTRL + SHIFT + S",  hl.dsp.exec_cmd("playerctl volume 0.1+"),       { locked = true, repeating = true })

-- Apps
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd("hyprlauncher"))
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("dolphin"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox -p Home --name firefox-home"))
hl.bind(altMod .. " + B", hl.dsp.exec_cmd("firefox -p Work --name firefox-work"))

-- Screenshots
hl.bind("Print",                        hl.dsp.exec_cmd("hyprshot -m output"))
hl.bind(mainMod .. " + Print",          hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind(altMod .. " + Print",  hl.dsp.exec_cmd("hyprshot -m region"))

-- Color picker
hl.bind(altMod .. " + C", hl.dsp.exec_cmd("hyprpicker -a"))

-- Switch workspaces
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
  hl.bind(altMod .. " + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })
