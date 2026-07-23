// Equivalent of modules.json's "idle_inhibitor":
//   { "format": "{icon}", "format-icons": { "activated": "", "deactivated": "" } }
//
// Quickshell has no direct idle_inhibitor binding, so this toggles a
// long-lived `systemd-inhibit` process on click, the same mechanism most
// idle-inhibit waybar/quickshell modules use under the hood.

import QtQuick
import Quickshell.Io

Rectangle {
    id: root
    property bool inhibited: false

    implicitWidth: 28
    implicitHeight: 28
    radius: 6
    color: "#1f2335"

    Text {
        anchors.centerIn: parent
        text: root.inhibited ? "" : ""
        color: root.inhibited ? "#7dd3fc" : "#565f89"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 15
    }

    Process {
        id: inhibitProc
        command: ["systemd-inhibit", "--what=idle:sleep", "--who=quickshell",
                  "--why=idle_inhibitor toggled from bar", "sleep", "infinity"]
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.inhibited = !root.inhibited
            inhibitProc.running = root.inhibited
        }
    }
}
