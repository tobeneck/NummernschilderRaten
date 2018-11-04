import QtQuick 2.0

Item {
    property string resultText: "keine gültige abkürzung"
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
            //anchors.leftMargin: 120
            //anchors.topMargin: (parent.height - font.pixelSize + 25) / 2
            font.family: localFont.name
            font.pixelSize: inputShield.height > inputShield.width * settings.licencePlateImageRatio ? (inputShield.width * settings.licencePlateImageRatio) * settings.textSizeImageHeightRatio : inputShield.height *settings.textSizeImageHeightRatio
            maximumLength: 3
            onTextChanged: checkToken(text)
            verticalAlignment: TextInput.AlignVCenter
            horizontalAlignment: TextInput.AlignHCenter
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
            text: resultText
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
