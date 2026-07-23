# SimpleBlueColorWaybar → Quickshell

A Quickshell port of https://github.com/d00m1k/SimpleBlueColorWaybar (a
bottom Hyprland bar with arch logo, workspaces, window title, tray-style
system stats, dual battery, and clock).

## Install

```sh
mkdir -p ~/.config/quickshell/bluebar
cp -r shell.qml modules ~/.config/quickshell/bluebar/
qs -c bluebar   # or add `exec-once = qs -c bluebar` to your Hyprland config
```

## Dependencies

- `quickshell` (obviously) + Qt6/QtQuick, built with the Hyprland, Pipewire
  and UPower service modules enabled
- `hyprland` (for workspaces/window/language modules)
- A Nerd Font, e.g. `ttf-jetbrains-mono-nerd` (referenced as
  `JetBrainsMono Nerd Font` — swap for whatever you have installed)
- `nmcli` (NetworkManager) for the network module
- `pavucontrol` for the volume module's click action
- `systemd` (for `systemd-inhibit`, used by the idle inhibitor)
- `upower` running, for the battery modules

## What's approximate, and why

- **Colors**: I could fetch `config.jsonc` and `modules.json` fine, but
  GitHub kept refusing the raw fetch for `style.css`, so the exact hex
  values from the original blue theme aren't reproduced here — I used a
  reasonable blue-on-dark palette instead (`#161821` background, `#1f2335`
  pills, `#3b82f6` / `#7dd3fc` accents). If you paste me the CSS, I can
  match it exactly.
- **hwmon path** (`Temperature.qml`) is copied verbatim from the original
  config and is specific to that machine's CPU sensor. Find yours with
  `ls /sys/class/hwmon/*/name` or `sensors`.
- **`idle_inhibitor`**: Quickshell has no built-in idle-inhibit binding, so
  clicking the icon spawns/kills a `systemd-inhibit --what=idle:sleep`
  process, which is the same mechanism most idle-inhibit implementations
  use under the hood.
- **`network`**: implemented by polling `nmcli` every 5s rather than a
  native NetworkManager service, since that API is still stabilizing across
  Quickshell releases. Works, just not event-driven.
- **Quickshell API drift**: this is a young, fast-moving project, and a few
  property names here (workspace fields, UPower device matching) are my
  best read of the current docs rather than something I could compile and
  test. If a specific line errors on your installed version, check
  https://quickshell.org/docs/ for that type — it's almost always a
  renamed property, not a structural issue.

## Layout mapping

| waybar (`config.jsonc`) | Quickshell (`shell.qml`) |
|---|---|
| `modules-left` | first `RowLayout` (ArchLogo, Workspaces) |
| `modules-center` | ActiveWindow |
| `modules-right` | second `RowLayout` (everything else) |
| `"layer": "top"` | `WlrLayershell.layer: WlrLayer.Top` |
| `"position": "bottom"` | `anchors.bottom/left/right: true` |
| `"height": 42` | `implicitHeight: 42` |
| `"spacing": 4` | `RowLayout { spacing: 4 }` |
