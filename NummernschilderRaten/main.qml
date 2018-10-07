import QtQuick 2.9
import QtQuick 2.11
import QtQuick.Controls 2.2

ApplicationWindow {
    id: window
    visible: true
    width: 697
    height: 1239
    title: qsTr("Tabs")

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                drawer.open()
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.66
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Page 1")
                width: parent.width
                onClicked: {
                    stackView.pop()
                    stackView.push("checkLicencePlate.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Page 2")
                width: parent.width
                onClicked: {
                    stackView.pop()
                    stackView.push("guessLicencePlate.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "checkLicencePlate.qml"
        anchors.fill: parent
    }
}
