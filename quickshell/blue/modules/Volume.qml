// Equivalent of modules.json's "pulseaudio" module:
//   format icons for volume level, mute state, and on-click: pavucontrol
//
// Quickshell talks to PipeWire directly (waybar's pulseaudio module really
// talks to PipeWire too, via its Pulse compatibility layer), so this reads
// the default sink live instead of polling.

import QtQuick
import Quickshell.Io
import Quickshell.Services.Pipewire

Rectangle {
    id: root
    readonly property var sink: Pipewire.defaultAudioSink
    readonly property real volumePct: Math.round((sink?.audio?.volume ?? 0) * 100)
    readonly property bool muted: sink?.audio?.muted ?? false

    implicitWidth: label.implicitWidth + 16
    implicitHeight: 28
    radius: 6
    color: "#1f2335"

    // Keeps the sink bound so its properties update live.
    PwObjectTracker { objects: [root.sink] }

    Text {
        id: label
        anchors.centerIn: parent
        text: (root.muted ? " " : " ") + root.volumePct + "%"
        color: "#c0caf5"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
    }

    Process { id: pavucontrolProc; command: ["pavucontrol"] }
    MouseArea { anchors.fill: parent; onClicked: pavucontrolProc.running = true }
}
