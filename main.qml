import QtQuick 2.12
import QtQuick.Window 2.12
import Monty 1.0

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Thermostat Example")

    SystemController {
        id: systemController
    }

    Loader {
        id: mainLoader
        anchors.fill: parent
        source: "./UI/HomeScreen/HomeScreen.qml"
    }
}
