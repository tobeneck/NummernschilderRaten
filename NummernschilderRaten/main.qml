//import QtQuick 2.9
import QtQuick 2.11
import QtQuick.Layouts 1.11//for layouts
import QtQuick.Controls 2.4

ApplicationWindow {
    id: window
    visible: true
    width: 517
    height: 920
    title: qsTr("Tabs")


    signal checkToken(string token)
    signal guessToken()

    function updateResultText(text){
        resultText.text = text
    }

    function setNewUserQuestion(ansẃer1, answer2, answer3, answer4, rightAnswer, cityName1, cityName2, cityName3, cityName4){

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
                questionCityName.text = cityName1
                break;
            case 2:
                button2.rightAnswer = true
                questionCityName.text = cityName2
                break;
            case 3:
                button3.rightAnswer = true
                questionCityName.text = cityName3
                break;
            case 4:
                button4.rightAnswer = true
                questionCityName.text = cityName4
                break;
        }
    }

    Item {
        id: checkLicencePlate

        FontLoader {
            id: localFont
            source: "qrc:/Fonts/EuroPlate.ttf"
        }

        Image {
            id: inputShield
            anchors.top: parent.rop
            anchors.left: parent.left
            anchors.right: parent.right
            height: 0.25107604017*width
            fillMode: Image.PreserveAspectFit
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

        Rectangle{
            id: questionField
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 5
            height: 0.25107604017*width*2//ratio of the picture in the button
            border.color: "black"
            border.width: 3
            radius: 10
            Text{
                id: questionStandartText
                text:"Zu welchem Kürzel gehört:"
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: parent.height/20
            }
            Text{
                id: questionCityName
                anchors.top: questionStandartText.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: parent.height /7
                wrapMode: Text.Wrap
            }
        }
        Rectangle{
            id: blankSpace1
            anchors.top: questionField.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 0.25107604017*width/3
        }

        Item{
            id: answerButtons
            anchors.top: blankSpace1.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 5
            height: 0.25107604017*width//ratio of the picture in the button
            CustomButton{
                id: button1
                height: parent.height/2-2*anchors.margins
                width: parent.width/2-2*anchors.margins
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 5
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
                height: parent.height/2-2*anchors.margins
                width: parent.width/2-2*anchors.margins
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.margins: 5
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
                height: parent.height/2-2*anchors.margins
                width: parent.width/2-2*anchors.margins
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.margins: 5
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
                height: parent.height/2 -2*anchors.margins
                width: parent.width/2-2*anchors.margins
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.margins: 5
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

        CustomProgressBar{
            anchors.top: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 5
            id: progressBar
            Layout.fillWidth: true
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
