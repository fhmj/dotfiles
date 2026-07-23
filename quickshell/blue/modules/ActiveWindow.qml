// Equivalent of the "hyprland/window" module in modules-center: shows the
// title of the currently focused window.

import QtQuick
import Quickshell.Hyprland

Text {
    id: root
    text: Hyprland.activeToplevel?.title ?? ""
    color: "#c0caf5"
    font.family: "JetBrainsMono Nerd Font"
    font.pixelSize: 13
    elide: Text.ElideRight
}
