import QtQuick 2.0

Item {
    FontLoader {
        id: localFont
        source: ":/../Fonts/EuroPlate.ttf"
    }

    Text{
        anchors.fill: parent
        text: "Hello World!"
        font.family: localFont.name
    }

    Image {
        id: inputShield
        source: ":/../Pictures/Nummernschild-201020596577.jpg"
        //697x175 pixels
        TextInput{
            anchors.fill: parent
            anchors.leftMargin: 120
            anchors.topMargin: (parent.height - font.pixelSize + 25) / 2
            font.family: localFont.name
            font.pixelSize: 125
            maximumLength: 3
        }
    }

    Text{
        anchors.top: inputShield.bottom
        anchors.horizontalCenter: inputShield.horizontalCenter
        text: "keine gültige abkürzung"
    }
}
