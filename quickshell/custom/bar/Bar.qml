import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import qs.modules
import ".."

PanelWindow {
  id: root

  property var modelData
  screen: modelData

  anchors {
    bottom: true
    left: true
    right: true
  }
  implicitHeight: Theme.barHeight

  WlrLayershell.layer: WlrLayershell.Top
  WlrLayershell.exclusiveZone: implicitHeight

  //color: "transparent"
  color: "#ddffdd"

  RightPill {
    anchors {
      top: parent.top
      bottom: parent.bottom
      left: parent.left
      topMargin: 8
      bottomMargin: 8
      leftMargin: 8
    }
  }
  // RowLayout {
  //   id: leftCluster

  //   anchors {
  //     left: parent.left
  //     verticalCenter: parent.verticalCenter
  //     leftMargin: Theme.margin * 2
  //   }

  //   LeftPill {}
  // }

  RowLayout {
    id: centerCluster

    anchors {
      horizontalCenter: parent.horizontalCenter
      verticalCenter: parent.verticalCenter
    }
    height: parent.height
    // spacing: 6

    Rectangle {
      color: "#00ffff"
      height: parent.height
      width: Theme.itemSize * 2

      Text {
        anchors.centerIn: parent
        text: "Center"
      }
    }
  }

  RowLayout {
    id: rightCluster

    anchors {
      right: parent.right
      verticalCenter: parent.verticalCenter
      rightMargin: 6
    }

    RightPill {}
  }
}
