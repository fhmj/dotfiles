// Equivalent of modules.json's "clock" module:
//   format "{:%H:%M | %e %B}", tooltip-format showing the calendar,
//   format-alt "{:%Y-%m-%d}"

import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    property date now: new Date()

    implicitWidth: label.implicitWidth + 16
    implicitHeight: 28
    radius: 6
    color: "#1f2335"

    Text {
        id: label
        anchors.centerIn: parent
        text: " " + Qt.formatDateTime(root.now, "hh:mm | d MMMM")
        color: "#c0caf5"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
    }

    Timer { interval: 1000; running: true; repeat: true; onTriggered: root.now = new Date() }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        ToolTip.visible: containsMouse
        ToolTip.text: Qt.formatDateTime(root.now, "yyyy MMMM")
    }
}
