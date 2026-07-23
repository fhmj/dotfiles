import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Hyprland
import ".."

RowLayout {
Repeater {
  id: root
  model: Hyprland.workspaces

  delegate: Rectangle {
    //anchors.fill: parent
    height: Theme.barHeight - Theme.horizontalPadding * 2
    // height: Theme.barHeight

    
    width: height
    radius: height / 2
    color: modelData.active ? "#ffdddd" : "transparent"

    Behavior on color {
      ColorAnimation { duration: 250 }
    }

    Text {
      anchors.centerIn: parent
      font.pixelSize: 14
      font.bold: modelData.active
      text: modelData.name
    }

    MouseArea {
      anchors.fill: parent
      cursorShape: Qt.PointingHandCursor
      onClicked: modelData.activate()
    }
  }
}
}
