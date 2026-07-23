// Combines what were separately modules.json's "custom/arch" and
// "hyprland/workspaces" into a single rounded "pill" container, per request.
//
// The pill's corner radius doubles as the diameter-defining radius for the
// active workspace's highlight circle (both use `pillRadius`), so the two
// stay visually consistent no matter how you resize things.

import QtQuick
import QtQuick.Controls
import Quickshell.Hyprland

Rectangle {
    id: root

    readonly property int pillRadius: 14      // fully-rounded "pill" ends
    readonly property int itemSize: 28        // per-workspace hit target / circle size
    readonly property int horizontalPadding: 10

    implicitHeight: itemSize
    implicitWidth: row.implicitWidth + horizontalPadding * 2
    radius: pillRadius
    color: "#1f2335"

    Row {
        id: row
        anchors.centerIn: parent
        spacing: 4

        // ---- arch logo ----
        Item {
            width: archLabel.implicitWidth + 8
            height: root.itemSize

            Text {
                id: archLabel
                anchors.centerIn: parent
                text: "󰣇"
                color: "#7dd3fc"
                font.family: "JetBrainsMono Nerd Font"
                font.pixelSize: 16
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                ToolTip.visible: containsMouse
                ToolTip.text: "btw"
            }
        }

        // ---- workspaces ----
        Repeater {
            model: Hyprland.workspaces

            delegate: Item {
                id: wsDelegate
                required property var modelData
                readonly property bool isActive: Hyprland.focusedWorkspace?.id === modelData.id

                width: root.itemSize
                height: root.itemSize

                // Highlight circle behind the active workspace, matching
                // the pill's own corner radius.
                Rectangle {
                    anchors.fill: parent
                    radius: root.pillRadius
                    color: "#3b82f6"
                    visible: wsDelegate.isActive
                }

                Text {
                    anchors.centerIn: parent
                    text: wsDelegate.modelData.name
                    color: wsDelegate.isActive ? "#0b0e14" : "#c0caf5"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 13
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + wsDelegate.modelData.name)
                }
            }
        }
    }
}
