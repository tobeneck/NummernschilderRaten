import QtQuick 2.0
import QtQuick.Layouts 1.11//for layouts
import QtQuick.Controls 2.1//for the popup

//NOTE: abandoned for now
//TODO:  new Timer for answers and Highscore Management

Item{
    id: guessLicencePlateHighscore

    property string label: "Kennzeichen Raten"

    function setNewUserQuestion(ansẃer1, answer2, answer3, answer4, rightAnswer, cityName1, cityName2, cityName3, cityName4){
        guessLicencePlateNormaly.setNewUserQuestion(ansẃer1, answer2, answer3, answer4, rightAnswer, cityName1, cityName2, cityName3, cityName4)
        timesOutTimer.start()
    }

    property int highscoreCount: 0

    ColumnLayout{
        anchors.fill: parent
        Rectangle{
            Layout.fillWidth: true
            Layout.leftMargin: settings.defaultAnchorMargins
            Layout.rightMargin: settings.defaultAnchorMargins
            Layout.topMargin: settings.defaultAnchorMargins
            height: parent.height / 16
            border.color: "black"
            border.width: 3
            radius: 10
        }

        GuessLicencePlate{
            id: guessLicencePlateNormaly
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    Timer{
        id: timesOutTimer
        repeat: false
        interval: 5000
        onTriggered: {
            popup.open()
        }
    }

    Popup {
        id: popup
        x: 100
        y: 100
        width: 50
        height: 50
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    }
}

