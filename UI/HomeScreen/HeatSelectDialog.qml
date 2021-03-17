import QtQuick 2.0
import Monty 1.0

Rectangle {
    id: heatSelectDialog
    signal destroyMe()

    anchors.fill: parent
    color: Qt.rgba( 0, 0, 0, 0)

    MouseArea {
        anchors.fill: parent
        onClicked: heatSelectDialog.destroyMe()
    }

    ListModel {
        id: heatModel
        ListElement { controlText: "Heat" }
        ListElement { controlText: "Cool" }
        ListElement { controlText: "Auto" }
    }

    Rectangle {
        id: innerRectangle
        radius: 5
        width: parent.width / 2
        height: parent.height * .8
        anchors.centerIn: parent
        color: "black"
        border.color: "white"
        border.width: 3
    }

    ListView {
        id: heatListView
        anchors.fill: innerRectangle
        interactive: false
        model: heatModel
        delegate: Rectangle {
            id: mainButton
            width: innerRectangle.width
            height: innerRectangle.height / 3
            color: "black"
            border.color: "white"
            border.width: 4
            radius: 5
            Text {
                id: mainText
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 42
                text: controlText
            }

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    mainButton.color = "white"
                    mainText.color = "black"
                }
                onReleased: {
                    mainButton.color = "black"
                    mainText.color = "white"
                }
                onClicked: {
                    if ( controlText === "Heat" )
                        systemController.setSystemState( SystemController.HEATING )
                    else if ( controlText === "Cool" )
                        systemController.setSystemState( SystemController.COOLING )
                    else if ( controlText === "Auto" )
                        systemController.setSystemState( SystemController.AUTO )

                    heatSelectDialog.destroyMe()
                }
            }
        }
    }
}
