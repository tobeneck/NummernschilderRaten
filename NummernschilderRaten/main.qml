//import QtQuick 2.9
import QtQuick 2.11
import QtQuick.Layouts 1.11//for layouts
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0//settings

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

        button1.cityName = cityName1
        button2.cityName = cityName2
        button3.cityName = cityName3
        button4.cityName = cityName4

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

    Settings{
        id: settings
        property real licencePlateImageRatio: 0.25107604017
        property int defaultAnchorMargins: 5
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
            height: settings.licencePlateImageRatio * width
            fillMode: Image.PreserveAspectFit
            source: "qrc:/Pictures/Nummernschild-201020596577.png"
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

        Item{
            id: resultTextSpace
            anchors.top: inputShield.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: settings.defaultAnchorMargins
            height: inputShield.height
            Text{
                id: resultText
                text: "keine gültige abkürzung"
                font.pixelSize: inputShield.height / 3
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.fill: parent
            }
        }

        Item{
            id: switchScreenButtons
            anchors.left: parent.left
            anchors.right: parent.right
            height: childrenRect.height
            anchors.top: resultTextSpace.bottom
            CustomButton{
                id: openGuessLicencePlate
                anchors.top: parent.top
                anchors.left: parent.left
                width: parent.width / 2 - settings.defaultAnchorMargins * 2
                height: width * settings.licencePlateImageRatio
                anchors.margins: settings.defaultAnchorMargins
                text: "Kennzeichen Raten"
                onClicked: stackView.push(guessLicencePlate)
            }
            CustomButton{
               id: openHighscoreMode
               anchors.top: parent.top
               anchors.right: parent.right
               width: parent.width / 2 - settings.defaultAnchorMargins * 2
               height: width * settings.licencePlateImageRatio
               anchors.margins: settings.defaultAnchorMargins
               text: "Kennzeichen Raten"
               Text{
                   anchors.left: parent.left
                   anchors.right: parent.right
                   anchors.bottom: parent.bottom
                   text: "- Highscore -"
                   font.pixelSize: parent.fontSize / 2
                   anchors.margins: settings.defaultAnchorMargins
                           horizontalAlignment: Text.AlignHCenter
               }
               onClicked: stackView.push(guessLicencePlateHighscore)
            }
            CustomButton{
                id: openCredits
                anchors.top:  openGuessLicencePlate.bottom
                anchors.left: parent.left
                width: parent.width / 2 - settings.defaultAnchorMargins * 2
                height: width * settings.licencePlateImageRatio
                anchors.margins: settings.defaultAnchorMargins
                text: "Credits und Infos"
                onClicked: stackView.push(infos)
            }
            CustomButton{
                id: openHighscoreTable
                anchors.top:  openHighscoreMode.bottom
                anchors.right: parent.right
                width: parent.width / 2 - settings.defaultAnchorMargins * 2
                height: width * settings.licencePlateImageRatio
                anchors.margins: settings.defaultAnchorMargins
                text: "Highscore Tabelle"
                onClicked: stackView.push(highscoreTable)
            }
        }
        Image {
            id: iconBottom
            anchors.top: switchScreenButtons.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: settings.defaultAnchorMargins
            scale: 0.5
            fillMode: Image.PreserveAspectFit
            source: "qrc:/Pictures/AppIcon.png"
            horizontalAlignment: Image.AlignHCenter
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
            anchors.margins: settings.defaultAnchorMargins
            height: parent.height/3
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

        CustomProgressBar{
            anchors.top: questionField.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: settings.defaultAnchorMargins
            id: progressBar
        }

        Item{
            id: answerButtons
            anchors.top: progressBar.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: parent.height / 3
            CustomLicencePlateButton{
                id: button1
                height: parent.height/2-2*anchors.margins
                width: parent.width/2-2*anchors.margins
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: settings.defaultAnchorMargins
                onDown: {
                    timer.start()
                    progressBar.start()
                    button1.lockAnswer()
                    button2.lockAnswer()
                    button3.lockAnswer()
                    button4.lockAnswer()
                }
            }
            CustomLicencePlateButton{
                id: button2
                height: parent.height/2-2*anchors.margins
                width: parent.width/2-2*anchors.margins
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.margins: settings.defaultAnchorMargins
                onDown: {
                    timer.start()
                    progressBar.start()
                    button1.lockAnswer()
                    button2.lockAnswer()
                    button3.lockAnswer()
                    button4.lockAnswer()
                }
            }
            CustomLicencePlateButton{
                id: button3
                height: parent.height/2-2*anchors.margins
                width: parent.width/2-2*anchors.margins
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.margins: settings.defaultAnchorMargins
                onDown: {
                    timer.start()
                    progressBar.start()
                    button1.lockAnswer()
                    button2.lockAnswer()
                    button3.lockAnswer()
                    button4.lockAnswer()
                }
            }
            CustomLicencePlateButton{
                id: button4
                height: parent.height/2 -2*anchors.margins
                width: parent.width/2-2*anchors.margins
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.margins: settings.defaultAnchorMargins
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
        Component.onCompleted: guessToken()
    }

    Item{
        id: infos
        Text{
            text: "infos"
            anchors.fill: parent
        }
    }

    Item{
        id: guessLicencePlateHighscore
        Text{
            text: "highscore"
            anchors.fill: parent
        }
    }

    Item{
        id: highscoreTable
        Text{
            text: "highscoretable"
            anchors.fill: parent
        }
    }

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
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

//            ItemDelegate { // should not be viewable
//                text: qsTr("Kennzeichen Nachschauen")
//                width: parent.width
//                onClicked: {
//                    stackView.pop()
//                    //stackView.push(checkLicencePlate)
//                    drawer.close()
//                }
//            }
            ItemDelegate {
                text: qsTr("Kennzeichen Raten")
                width: parent.width
                onClicked: {
//                    stackView.pop()
                    stackView.push(guessLicencePlate)
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Kennzeichen Raten Highscore")
                width: parent.width
                onClicked: {
//                    stackView.pop()
                    stackView.push(guessLicencePlateHighscore)
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Highscore Tabelle")
                width: parent.width
                onClicked: {
//                    stackView.pop()
                    stackView.push(highscoreTable)
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Infos")
                width: parent.width
                onClicked: {
//                    stackView.pop()
                    stackView.push(infos)
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
