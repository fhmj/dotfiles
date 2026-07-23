import QtQuick
import QtQuick.Layouts
import qs

Rectangle {
  width: row.width
  // Layout.preferredHeight: parent.height

  color: "#ff0000"
  // //height: Theme.barHeight
  // width: row.width

  // Rectangle {
  //   color: "#00ff00"
  //   height: parent.height
  //   width: height
  // }
  Text {
    id: row
    anchors.centerIn: parent
    text: "Right 123 Right 321"
    color: "#00ddff"
  }
}

