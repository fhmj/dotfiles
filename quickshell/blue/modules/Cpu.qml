// Equivalent of modules.json's "cpu" module: { "format": " {usage}%" }
// Computed from /proc/stat deltas, same source waybar's cpu module uses.

import QtQuick
import Quickshell.Io

Rectangle {
    id: root
    property real usage: 0
    property real prevIdle: 0
    property real prevTotal: 0

    implicitWidth: label.implicitWidth + 16
    implicitHeight: 28
    radius: 6
    color: "#1f2335"

    Text {
        id: label
        anchors.centerIn: parent
        text: " " + Math.round(root.usage) + "%"
        color: "#c0caf5"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
    }

    Process {
        id: proc
        command: ["sh", "-c", "head -1 /proc/stat"]
        stdout: StdioCollector {
            onStreamFinished: {
                const n = text.trim().split(/\s+/).slice(1).map(Number)
                const idle = n[3] + n[4]
                const total = n.reduce((a, b) => a + b, 0)
                const dIdle = idle - root.prevIdle
                const dTotal = total - root.prevTotal
                if (root.prevTotal > 0 && dTotal > 0)
                    root.usage = 100 * (1 - dIdle / dTotal)
                root.prevIdle = idle
                root.prevTotal = total
            }
        }
    }

    Timer { interval: 2000; running: true; repeat: true; triggeredOnStart: true; onTriggered: proc.running = true }
}
