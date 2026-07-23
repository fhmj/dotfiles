import QtQuick
import QtQuick.Layouts
import qs
import qs.modules as Modules

Rectangle {
  id: leftPill

  implicitHeight: Theme.barHeight - Theme.verticalPadding * 2
  implicitWidth: row.implicitWidth

  radius: height / 2
  //color: Theme.colors.surface
  color: "#0000ff"

  RowLayout {
    id: row
    anchors.centerIn: parent

    spacing: 0

    Modules.ArchLogo {}
    Modules.Workspaces {}
  }
}
