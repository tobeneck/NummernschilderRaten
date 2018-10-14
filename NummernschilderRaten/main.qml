//import QtQuick 2.9
import QtQuick 2.11
import QtQuick.Layouts 1.11//for layouts
import QtQuick.Controls 2.4

ApplicationWindow {
    id: window
    visible: true
    width: 697
    height: 1239
    title: qsTr("Tabs")


    signal checkToken(string token)
    signal guessToken()

    function updateResultText(text){
        resultText.text = text
    }

    function setNewUserQuestion(ansẃer1, answer2, answer3, answer4, rightAnswer, cityName){
        question.text = cityName
        button1.text = ansẃer1
        button2.text = answer2
        button3.text = answer3
        button4.text = answer4

        button1.enabled = true
        button2.enabled = true
        button3.enabled = true
        button4.enabled = true

        button1.rightAnswer = false
        button2.rightAnswer = false
        button3.rightAnswer = false
        button4.rightAnswer = false

        switch(rightAnswer){
            case 1:
                button1.rightAnswer = true
                break;
            case 2:
                button2.rightAnswer = true
                break;
            case 3:
                button3.rightAnswer = true
                break;
            case 4:
                button4.rightAnswer = true
                break;
        }
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
                onTextChanged: checkToken(text)
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

        Timer{
            id: timer
            interval: 3000
            repeat: false
            onTriggered:{
                progressBar.stop()
                guessToken()
            }

        }

        ColumnLayout{
            anchors.fill: parent
            anchors.margins: 5
            Rectangle{
                Layout.fillHeight: true
                Layout.fillWidth: true
                border.color: "grey"
                border.width: 1
                Row{
                    anchors.fill: parent
                    Text{
                        text:"Zu welchem Körzel gehört"
                    }
                    Text{
                        id: question
                    }
                }
            }

            CustomProgressBar{
                id: progressBar
                Layout.fillWidth: true
            }

            RowLayout{
                GridLayout{
                    Layout.fillHeight: true
//                    Layout.fillWidth: true
                    columns: 2
                    CustomButton{
                        id: button1
                        onDown: {
                            timer.start()
                            progressBar.start()
                            button1.lockAnswer()
                            button2.lockAnswer()
                            button3.lockAnswer()
                            button4.lockAnswer()
                        }
                    }
                    CustomButton{
                        id: button2
                        onDown: {
                            timer.start()
                            progressBar.start()
                            button1.lockAnswer()
                            button2.lockAnswer()
                            button3.lockAnswer()
                            button4.lockAnswer()
                        }
                    }
                    CustomButton{
                        id: button3
                        onDown: {
                            timer.start()
                            progressBar.start()
                            button1.lockAnswer()
                            button2.lockAnswer()
                            button3.lockAnswer()
                            button4.lockAnswer()
                        }
                    }
                    CustomButton{
                        id: button4
                        onDown: {
                            timer.start()
                            progressBar.start()
                            button1.lockAnswer()
                            button2.lockAnswer()
                            button3.lockAnswer()
                            button4.lockAnswer()
                        }
                    }
                }
            }
        }
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
                text: qsTr("Kennzeichen Nachschauen")
                width: parent.width
                onClicked: {
                    stackView.pop()
                    stackView.push(checkLicencePlate)
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Kennzeichen Raten")
                width: parent.width
                onClicked: {
                    stackView.pop()
                    stackView.push(guessLicencePlate)
                    guessToken()
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Credits")
                width: parent.width
                onClicked: {
                    stackView.pop()
                    stackView.push(guessLicencePlate)
                    getNewQuestion()
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
