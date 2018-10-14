import QtQuick 2.6
import QtQuick.Controls 2.1

Button {
    id: control

    property bool rightAnswer: false
    signal down()

    function lockAnswer(){
        control.enabled = false
        if(rightAnswer)
            buttonBackground.color = "green"
    }

    contentItem: Text {
        id: buttonText
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.down ? "grey" : "grey"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
        onTextChanged: {
            buttonBackground.border.color = "grey"
            buttonBackground.color = "white"
            buttonText.color = "grey"
        }
    }

    background: Rectangle {
        id: buttonBackground
        implicitWidth: 100
        implicitHeight: 40
        opacity: enabled ? 1 : 0.3
        border.color: control.down ? "grey" : "grey"
        border.width: 1
        radius: 2
    }

    onClicked: {
        buttonBackground.color = rightAnswer ? "green" : "red"
        buttonBackground.border.color = "black"
        buttonText.color = "black"
        down()
    }
}
