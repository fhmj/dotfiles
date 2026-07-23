// Equivalent of modules.json's "temperature" module:
//   { "interval": 10, "hwmon-path": "...", "critical-threshold": 100 }
//
// NOTE: the hwmon path below is copied verbatim from the original config
// and is specific to that person's hardware. Find yours with:
//   ls /sys/class/hwmon/*/name  &&  cat /sys/class/hwmon/hwmonN/name
// or just use `sensors` and pick the right hwmon symlink.

import QtQuick
import Quickshell.Io

Rectangle {
    id: root
    property int value: 0
    readonly property int criticalThreshold: 100

    implicitWidth: label.implicitWidth + 16
    implicitHeight: 28
    radius: 6
    color: "#1f2335"

    Text {
        id: label
        anchors.centerIn: parent
        text: " " + root.value + "°C"
        color: root.value >= root.criticalThreshold ? "#f7768e" : "#c0caf5"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
    }

    Process {
        id: proc
        command: ["cat", "/sys/devices/platform/coretemp.0/hwmon/hwmon4/temp1_input"]
        stdout: StdioCollector { onStreamFinished: root.value = Math.round(parseInt(text) / 1000) }
    }

    Timer { interval: 10000; running: true; repeat: true; triggeredOnStart: true; onTriggered: proc.running = true }
}
