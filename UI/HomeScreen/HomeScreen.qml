import QtQuick 2.0
import Monty 1.0
Item {
    id: homeScreen
    property var heatSelectDialogHolder: null

    function createHeatSelectDialog() {
        if ( heatSelectDialogHolder === null ) {
            var component = Qt.createComponent( "HeatSelectDialog.qml" )
            heatSelectDialogHolder = component.createObject( homeScreen, {"x":0,"y":0})
            if ( heatSelectDialogHolder ) {
                heatSelectDialogHolder.anchors.fill = homeScreen
                heatSelectDialogHolder.destroyMe.connect( destroyHeatSelectDialog )
            }
        }
    }

    function destroyHeatSelectDialog() {
        if ( heatSelectDialogHolder !== null ) {
            heatSelectDialogHolder.destroy()
            heatSelectDialogHolder = null
        }
    }

    Rectangle {
        id: mainBackground
        anchors.fill: parent
        color: "black"
    }

    Text {
        id: currentTempText
        anchors.centerIn: parent
        color: "white"
        font.pixelSize: 200
        text: systemController.currentSystemTemperature
    }

    Text {
        id: systemStatus
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: currentTempText.bottom
            topMargin: 20
        }
        font.pixelSize: 30
        color: "white"
        text: systemController.systemStatusMessage
    }

    Image {
        id: heatCoolSelectIcon
        anchors {
            top: temperatureSlider.top
            right: currentTempText.left
            rightMargin: 100
        }
        width: 70
        height: 70
        source: {
            if ( systemController.systemState === SystemController.HEATING )
               return "qrc:/UI/Assets/flame.png"
            if ( systemController.systemState === SystemController.COOLING )
               return "qrc:/UI/Assets/ice-crystal.png"
            if ( systemController.systemState === SystemController.AUTO )
               return "qrc:/UI/Assets/auto.png"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: createHeatSelectDialog()
        }
    }

    Image {
        id: settingsIcon
        anchors {
            bottom: temperatureSlider.bottom
            right: currentTempText.left
            rightMargin: 100
        }
        width: 70
        height: 70
        source: "qrc:/UI/Assets/settings.png"
        MouseArea {
            anchors.fill: parent
            onClicked: mainLoader.source = "../SettingsScreen/SettingsScreen.qml"
        }
    }

    TemperatureControlSlider {
        id: temperatureSlider
        value: systemController.targetTemp
        anchors {
            top: parent.top
            bottom: parent.bottom
            left: currentTempText.right
            leftMargin: 100
            topMargin: 80
            bottomMargin: 80
        }
    }
}
