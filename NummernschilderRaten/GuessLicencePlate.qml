import QtQuick 2.0

Item{
    id: guessLicencePlate

    property string label: "Kennzeichen Raten"

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

    signal wrongAnswer()
    signal rightAnswer()

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
                rightAnswer ? rightAnswer() : wrongAnswer()
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
                rightAnswer ? rightAnswer() : wrongAnswer()
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
                rightAnswer ? rightAnswer() : wrongAnswer()
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
                rightAnswer ? rightAnswer() : wrongAnswer()
            }
        }
    }

    Component.onCompleted: {
        loadTimer.start()
    }
    Timer{
        id: loadTimer
        repeat: false
        onTriggered: guessToken()
        interval: 500
    }
}

