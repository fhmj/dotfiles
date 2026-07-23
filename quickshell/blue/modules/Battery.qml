// Equivalent of modules.json's "battery" / "battery#bat2" modules:
//   states (warning 30 / critical 15), charging/plugged icons, per-device
//   "bat": "BAT2" targeting a specific battery.
//
// Instantiated twice from shell.qml, once per physical battery, matching
// the original two-module setup.

import QtQuick
import Quickshell.Services.UPower

Rectangle {
    id: root
    required property string batteryName   // e.g. "BAT0", "BAT2"

    readonly property var device: {
        for (const d of UPower.devices.values) {
            if (d.isLaptopBattery && d.nativePath && d.nativePath.indexOf(batteryName) !== -1)
                return d
        }
        return null
    }

    readonly property int pct: device ? Math.round(device.percentage) : 0
    readonly property bool charging: device ? device.state === UPowerDeviceState.Charging : false
    readonly property bool warning: pct <= 30
    readonly property bool critical: pct <= 15

    visible: device !== null
    implicitWidth: visible ? label.implicitWidth + 16 : 0
    implicitHeight: 28
    radius: 6
    color: "#1f2335"

    Text {
        id: label
        anchors.centerIn: parent
        text: (root.charging ? " " : root.batteryIcon(root.pct)) + " " + root.pct + "%"
        color: root.critical ? "#f7768e" : (root.warning ? "#e0af68" : "#c0caf5")
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 13
    }

    function batteryIcon(p) {
        if (p >= 90) return ""
        if (p >= 60) return ""
        if (p >= 40) return ""
        if (p >= 20) return ""
        return ""
    }
}
