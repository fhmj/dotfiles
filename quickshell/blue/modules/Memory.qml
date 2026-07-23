// Equivalent of modules.json's "memory" module: { "format": " {}%" }

import QtQuick
import Quickshell.Io

Rectangle {
    id: root
    property int usage: 0

    implicitWidth: label.implicitWidth + 16
    implicitHeight: 28
    radius: 6
    color: "#1f2335"

    Text {
        id: label
        anchors.centerIn: parent
        text: " " + root.usage + "%"
        color: "#c0caf5"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
    }

    Process {
        id: proc
        command: ["sh", "-c", "free | awk '/Mem:/ {printf \"%.0f\", $3/$2*100}'"]
        stdout: StdioCollector { onStreamFinished: root.usage = parseInt(text) || 0 }
    }

    Timer { interval: 5000; running: true; repeat: true; triggeredOnStart: true; onTriggered: proc.running = true }
}
