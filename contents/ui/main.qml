import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0

Item {
  id: root
  property string symbol_restrained:  "\uD83D\uDD12"
  property string color_restrained:   "green"
  property string symbol_inhibitated: "\uD83D\uDD13"
  property string color_inhibitated:  "red"
  property string symbol_inhibitions: "\uD83D\uDD13"
  property string color_inhibitions:  "gray"

  Plasmoid.compactRepresentation: Representation {}
  Plasmoid.fullRepresentation: Representation {}
}
