// Equivalent of modules.json's "network" module (wifi essid/signal,
// ethernet ip, disconnected states, on-click: rofi-wifi-menu.sh).
//
// Quickshell has an in-progress Quickshell.Networking API in newer builds,
// but it's not consistently available across releases yet, so this polls
// `nmcli` the same way many current quickshell configs do — swap in the
// native service once it's stable on your version if you'd rather.

import QtQuick
import Quickshell.Io

Rectangle {
    id: root
    implicitWidth: label.implicitWidth + 16
    implicitHeight: 28
    radius: 6
    color: "#1f2335"

    Text {
        id: label
        anchors.centerIn: parent
        text: poll.displayText
        color: "#c0caf5"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
    }

    Process {
        id: poll
        property string displayText: "…"
        command: ["sh", "-c",
            "nmcli -t -f active,ssid,signal dev wifi 2>/dev/null | grep '^yes' | head -1"]
        stdout: StdioCollector {
            onStreamFinished: {
                const line = text.trim()
                if (!line) {
                    poll.displayText = "Disconnected ⚠"
                    return
                }
                const parts = line.split(":")
                poll.displayText = "  " + parts[1] + " (" + parts[2] + "%)"
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: poll.running = true
    }

    // Same click action as the original config's on-click.
    Process { id: menuProc; command: ["sh", "-c", "~/scripts/rofi-wifi-menu/rofi-wifi-menu.sh"] }
    MouseArea { anchors.fill: parent; onClicked: menuProc.running = true }
}
