//import QtQuick 2.9
import QtQuick 2.11
import QtQuick.Layouts 1.11//for layouts
import QtQuick.Controls 2.4
import Qt.labs.settings 1.0//settings

ApplicationWindow {
    id: window
    visible: true
    width: 288//517
    height: 511//920


    title: qsTr("Tabs")


    signal checkToken(string token)
    signal guessToken()

    function updateResultText(text){
        try{
            stackView.currentItem.resultText = text
        }
        catch(err){
            print("Error: "+ err.message + " Guess it was not the right time for a new Question")
        }
    }

    function setNewUserQuestion(ansẃer1, answer2, answer3, answer4, rightAnswer, cityName1, cityName2, cityName3, cityName4){
        try{
            stackView.currentItem.setNewUserQuestion(ansẃer1, answer2, answer3, answer4, rightAnswer, cityName1, cityName2, cityName3, cityName4)
        }
        catch(err){
            print("Error: "+ err.message + " Guess it was not the right time for a new Question")
        }
    }

    Settings{
        id: settings
        property real licencePlateImageRatio: 0.25107604017
        property int defaultAnchorMargins: 5
        property real textSizeImageHeightRatio: 1/1.1
        property int defaultRectRadius: 10
    }

    Component{
        id: checkLicencePlate
        CheckLicencePlate{}
    }

    Component{
        id: guessLicencePlate
        GuessLicencePlate{}
    }

    Component{
        id: infos
        Infos{}
    }

    Component{
        id: highscoreTable
        HighscoreTable{}
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

        Label {
            text: stackView.currentItem.label
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
                text: qsTr("Kennzeichen Raten")
                width: parent.width
                onClicked: {
                    stackView.push(guessLicencePlate)
                    drawer.close()
                }
            }
//NOTE: abandoned the Highscore functionality for now
//            ItemDelegate {
//                text: qsTr("Kennzeichen Raten Highscore")
//                width: parent.width
//                onClicked: {
//                    stackView.push(guessLicencePlateHighscore)
//                    drawer.close()
//                }
//            }
//            ItemDelegate {
//                text: qsTr("Highscore Tabelle")
//                width: parent.width
//                onClicked: {
//                    stackView.push(highscoreTable)
//                    drawer.close()
//                }
//            }
            ItemDelegate {
                text: qsTr("Infos")
                width: parent.width
                onClicked: {
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
