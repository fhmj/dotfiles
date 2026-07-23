// shell.qml — entry point.
// Equivalent of waybar's config.jsonc: defines the bar's position/size and
// which modules go left / center / right.
//
//   "layer": "top"        -> WlrLayershell.layer: WlrLayer.Top
//   "position": "bottom"  -> anchors.bottom / left / right
//   "height": 42          -> implicitHeight: 42
//   "spacing": 4          -> RowLayout spacing: 4
//   modules-left/center/right -> the three RowLayouts below

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland

import "modules" as Modules

Scope {
    id: shell

    // One bar per connected monitor, mirroring waybar's default behaviour
    // (and modules.json's "all-outputs": true for workspaces).
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            property var modelData
            screen: modelData

            anchors {
                bottom: true
                left: true
                right: true
            }
            implicitHeight: 42
            color: "#161821"

            WlrLayershell.layer: WlrLayer.Top
            // Exclusion zone defaults to "Automatic", which reserves screen
            // space the same way waybar's layer-shell surface does.

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 8
                anchors.rightMargin: 8
                spacing: 4

                // ---------------- modules-left ----------------
                // Arch logo + workspaces live inside one rounded pill.
                Modules.LeftGroup {
                    Layout.alignment: Qt.AlignVCenter
                }

                Item { Layout.fillWidth: true }

                // ---------------- modules-center ----------------
                Modules.ActiveWindow {
                    Layout.maximumWidth: bar.width * 0.4
                    Layout.alignment: Qt.AlignVCenter
                }

                Item { Layout.fillWidth: true }

                // ---------------- modules-right ----------------
                RowLayout {
                    spacing: 4
                    Modules.IdleInhibitor {}
                    Modules.Volume {}
                    Modules.Network {}
                    Modules.Cpu {}
                    Modules.Memory {}
                    Modules.Temperature {}
                    Modules.Language {}
                    Modules.Battery { batteryName: "BAT0" }
                    Modules.Battery { batteryName: "BAT2" }
                    Modules.Clock {}
                }
            }
        }
    }
}
