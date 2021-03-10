import QtQuick 2.0

Item {
    ListModel {
        id: settingsMainMenuListModel
        ListElement { menuText: "Temperature Units"; iconSource: "qrc:/UI/Assets/thermometer.png" }
        ListElement { menuText: "Schedule"; iconSource: "qrc:/UI/Assets/calendar.png" }
        ListElement { menuText: "WiFi Settings"; iconSource: "qrc:/UI/Assets/wifi.png" }
        ListElement { menuText: "About"; iconSource: "qrc:/UI/Assets/info-button.png" }

    }

    Rectangle {
        id: stackViewBackground
        width: parent.width * .7
        height: parent.height * .7
        anchors.centerIn: parent
        radius: 5
        color: "black"
        border.width: 3
        border.color: "white"
    }

    ListView {
        id: settingsListView
        anchors.fill: stackViewBackground
        model: settingsMainMenuListModel
        interactive: false
        delegate: Rectangle {
            id: mainButton
            width: settingsListView.width
            height: settingsListView.height / 4
            color: "black"
            border.color: "white"
            border.width: 4
            radius: 5

            Image {
                id: iconImage
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 30
                }
                source: iconSource
                height: 48
                width: 48
            }

            Text {
                id: mainText
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: iconImage.right
                    leftMargin: 40
                }

                color: "white"
                font.pixelSize: 30
                text: menuText
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
                    settingsStackView.push( "AboutPage.qml" )
                }
            }
        }
    }
}
