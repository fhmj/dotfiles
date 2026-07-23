// Equivalent of modules.json's "hyprland/language" module:
//   { "format": " {}", "format-en": "EN", "format-ru": "RU" }
//
// Polls `hyprctl devices -j` for the active keyboard layout. If your
// Quickshell version exposes keyboard layout directly through the
// Hyprland service, prefer that over shelling out.

import QtQuick
import Quickshell.Io

Rectangle {
    id: root
    property string layout: "EN"

    implicitWidth: label.implicitWidth + 16
    implicitHeight: 28
    radius: 6
    color: "#1f2335"

    Text {
        id: label
        anchors.centerIn: parent
        text: " " + root.layout
        color: "#c0caf5"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
    }

    Process {
        id: proc
        command: ["hyprctl", "devices", "-j"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const data = JSON.parse(text)
                    const kb = data.keyboards.find(k => k.main) ?? data.keyboards[0]
                    const active = kb?.active_keymap ?? "English"
                    root.layout = active.startsWith("Russian") ? "RU" : "EN"
                } catch (e) {
                    // keep previous value on parse failure
                }
            }
        }
    }

    Timer { interval: 3000; running: true; repeat: true; triggeredOnStart: true; onTriggered: proc.running = true }
}
