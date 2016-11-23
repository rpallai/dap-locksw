import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as Components

Item {
  id: main
  
  property int inhibitated: 0
  property string symbol: root.symbol_restrained
  property string color: root.color_restrained
  //
  property int cookie: -1

  property QtObject pmSource: PlasmaCore.DataSource {
    engine: "powermanagement"
    connectedSources: ["PowerDevil"]
  }
  
  function toggleState() {
    if (main.inhibitated) {
      var service = pmSource.serviceForSource("PowerDevil")
      var op = service.operationDescription("stopSuppressingScreenPowerManagement");
      op.cookie = main.cookie;
      var job = service.startOperationCall(op);
      job.finished.connect(function(job) {
        console.error("inhibitation disabled");
        main.inhibitated = 0;
        main.cookie = -1;
        main.symbol = root.symbol_restrained;
        main.color = root.color_restrained;
      });
    } else {
      var service = pmSource.serviceForSource("PowerDevil")
      var op = service.operationDescription("beginSuppressingScreenPowerManagement");
      op.reason = "Dap's lock switch plasmoid has enabled system-wide inhibition";
      var job = service.startOperationCall(op);
      job.finished.connect(function(job) {
        console.error("inhibitation enabled");
        main.inhibitated = 1;
        main.cookie = job.result;
        main.symbol = root.symbol_inhibitated;
        main.color = root.color_inhibitated;
      });
    }
  }

  Rectangle {
    height: parent.height
    // transparent
    color: "#00FFFFFF"

    Text {
      text: main.symbol
      color: main.color
      font.pixelSize: 24

      MouseArea {
        anchors.fill: parent
        onClicked: {
          toggleState();
        }
      }
    }
  }
}
