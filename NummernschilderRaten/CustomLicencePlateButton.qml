import QtQuick 2.6
import QtQuick.Controls 2.1

Button {
    id: control

    property bool rightAnswer: false
    property string cityName: ""
    signal down()

    function lockAnswer(){
        control.enabled = false
        if(rightAnswer)
            buttonBackground.border.color = "green"
        displayCityName.color = "black"
    }

    FontLoader {
        id: localFont
        source: "qrc:/Fonts/EuroPlate.ttf"
    }

    contentItem: Text {
        id: buttonText
        text: control.text
        color: "black"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        font.family: localFont.name
        font.pixelSize: backgroundPickture.height > backgroundPickture.width * settings.licencePlateImageRatio ? (backgroundPickture.width * settings.licencePlateImageRatio) * settings.textSizeImageHeightRatio : backgroundPickture.height *settings.textSizeImageHeightRatio
        opacity: enabled ? 1 : 0.3
        onTextChanged: {
            //reset the button
            buttonBackground.border.color = "black"
            buttonText.color = "black"
            displayCityName.color = "transparent"
        }
    }

    Text{
        id: displayCityName
        text: cityName
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 5
        font.bold: true
        wrapMode: Text.Wrap
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
    }

    background: Rectangle {
        id: buttonBackground
        border.color: enabled ? "black" : rightAnswer ? "green" : "red"
        border.width: 3
        radius: 10
        Image {
            id: backgroundPickture
            source: "qrc:/Pictures/Nummernschild-201020596577.png"
            anchors.fill: parent
            anchors.margins: 10
            fillMode: Image.PreserveAspectFit
            opacity: enabled ? 1.0 : 0.3
            //697x175 pixels
        }
    }

    onClicked: {
        buttonBackground.border.color = rightAnswer ? "green" : "red"
        down()
    }
}
