import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as Components

Item {
  id: main
  
  property bool inhibitated: false
  property bool has_inhibitions: false
  property string symbol: root.symbol_restrained
  property string color: root.color_restrained
  //
  property int cookie: -1

  property QtObject pmSource: PlasmaCore.DataSource {
    engine: "powermanagement"
    connectedSources: ["PowerDevil"]

    onSourceAdded: {
      disconnectSource(source);
      connectSource(source);
    }
    onSourceRemoved: {
      disconnectSource(source);
    }
    onDataChanged: {
      if (typeof pmSource.data["Inhibitions"] !== "undefined") {
        var has_inhibitions = false;
        console.error("current inhibitions:");
        for(var key in pmSource.data["Inhibitions"]) {
          console.error(key);
          has_inhibitions = true;
        }
        main.has_inhibitions = has_inhibitions;
      }
      if (!main.inhibitated) {  // aka. monitoring mode
        updateIcon();
      }
    }
  }
  
  function toggleState() {
    if (main.inhibitated) {
      var service = pmSource.serviceForSource("PowerDevil")
      var op = service.operationDescription("stopSuppressingScreenPowerManagement");
      op.cookie = main.cookie;
      var job = service.startOperationCall(op);
      job.finished.connect(function(job) {
        console.error("inhibitation disabled");
        main.inhibitated = false;
        main.cookie = -1;
        updateIcon();
      });
    } else {
      var service = pmSource.serviceForSource("PowerDevil")
      var op = service.operationDescription("beginSuppressingScreenPowerManagement");
      op.reason = "Dap's lock switch plasmoid has enabled system-wide inhibition";
      var job = service.startOperationCall(op);
      job.finished.connect(function(job) {
        console.error("inhibitation enabled");
        main.inhibitated = true;
        main.cookie = job.result;
        updateIcon();
      });
    }
  }

  function updateIcon() {
    if (main.inhibitated) {
      main.symbol = root.symbol_inhibitated;
      main.color = root.color_inhibitated;
    } else {
      if (main.has_inhibitions) {
        main.symbol = root.symbol_inhibitions;
        main.color = root.color_inhibitions;
      } else {
        main.symbol = root.symbol_restrained;
        main.color = root.color_restrained;
      }
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
