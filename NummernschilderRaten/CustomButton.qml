import QtQuick 2.6
import QtQuick.Controls 2.1

Button {
    id: control

    property int fontSize: height / 3
    contentItem: Text {
        id: buttonText
        text: control.text
        color: "black"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        opacity: enabled ? 1 : 0.3
        font.pixelSize: fontSize
    }

    background: Rectangle {
        id: buttonBackground
        color: pressed ? "lightgrey" : "white"
        border.color: "black"
        border.width: 3
        radius: 10
    }
}
