import QtQuick 2.6
import QtQuick.Controls 2.1

Button {
    id: control

    property bool rightAnswer: false
    signal down()

    function lockAnswer(){
        control.enabled = false
        if(rightAnswer)
            buttonBackground.border.color = "green"
    }

    FontLoader {
        id: localFont
        source: "qrc:/Fonts/EuroPlate.ttf"
    }

    contentItem: Text {
        id: buttonText
        text: control.text
//        opacity: enabled ? 1.0 : 0.3
        color: "black"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        font.family: localFont.name
        font.pixelSize: parent.height / 2
        onTextChanged: {
            buttonBackground.border.color = "black"
            buttonText.color = "black"
        }
    }

    background: Rectangle {
        id: buttonBackground
//        opacity: enabled ? 1 : 0.3
        border.color: enabled ? "black" : rightAnswer ? "green" : "red"
        border.width: 3
        radius: 10
        Image {
            source: "qrc:/Pictures/Nummernschild-201020596577.jpg"
            anchors.fill: parent
            anchors.margins: 10
            fillMode: Image.PreserveAspectFit
            //697x175 pixels
        }
    }

    onClicked: {
        buttonBackground.border.color = rightAnswer ? "green" : "red"
        down()
    }
}
