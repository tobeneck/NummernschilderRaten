import QtQuick 2.9
import QtQuick 2.11
import QtQuick.Controls 2.2

ApplicationWindow {
    id: window
    visible: true
    width: 697
    height: 1239
    title: qsTr("Tabs")


    signal check(string token)

    function updateResultText(text){
        resultText.text = text
    }

    Item {
        id: checkLicencePlate

        FontLoader {
            id: localFont
            source: "qrc:/Fonts/EuroPlate.ttf"
        }

        Text{
            anchors.fill: parent
            text: "Hello World!"
            font.family: localFont.name
        }

        Image {
            id: inputShield
            source: "qrc:/Pictures/Nummernschild-201020596577.jpg"
            //697x175 pixels
            TextInput{
                anchors.fill: parent
                anchors.leftMargin: 120
                anchors.topMargin: (parent.height - font.pixelSize + 25) / 2
                font.family: localFont.name
                font.pixelSize: 125
                maximumLength: 3
                onTextChanged: check(text)
            }
        }

        Text{
            id: resultText
            anchors.top: inputShield.bottom
            anchors.horizontalCenter: inputShield.horizontalCenter
            text: "keine gültige abkürzung"
        }
    }

    Item{
        id: guessLicencePlate
    }


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

//        Label {
//            text: stackView.currentItem.title
//            anchors.centerIn: parent
//        }
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
                    stackView.push(checkLicencePlate)
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Page 2")
                width: parent.width
                onClicked: {
                    stackView.pop()
                    stackView.push(guessLicencePlate)
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: checkLicencePlate
        anchors.fill: parent
    }
}
