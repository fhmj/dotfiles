import QtQuick
import Quickshell
import qs.bar
import "modules" as Modules

Scope {
  id: root

  Variants {
    model: Quickshell.screens

    Bar {}
  }
}
