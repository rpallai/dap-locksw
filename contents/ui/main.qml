import QtQuick 2.0
import org.kde.plasma.plasmoid 2.0

Item {
  id: root
  property string symbol_restrained:  "\uD83D\uDD12"
  property string color_restrained:   "green"
  property string symbol_inhibitated: "\uD83D\uDD13"
  property string color_inhibitated:  "red"

  Plasmoid.compactRepresentation: Representation {}
  Plasmoid.fullRepresentation: Representation {}
}
