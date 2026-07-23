pragma Singleton

import QtQuick
import "palettes" as Palettes

QtObject {
  id: theme

  // property QtObject colors: catppuccin
  property QtObject colors: QtObject {
    property color background: "#161821"
    property color surface: "#07070f"
  }

  property int barHeight: 42
  property int itemSize: 32
  property int pillRadius: itemSize / 2 
  property int horizontalPadding: 8
  property int verticalPadding: 4
  property int margin: 8

  property QtObject catppuccin: Palettes.CatppuccinFrappe {}
  property QtObject tokyoNight: Palettes.TokyoNight {}

  function setPalette(themeName) {
    if (themeName === "tokyonight") {
      theme.colors = tokyoNight
    } else if (themeName === "catppuccin") {
      theme.colors = catppuccin
    } else {
      console.warn("Theme not found: " + themeName)
    }
  }
}
