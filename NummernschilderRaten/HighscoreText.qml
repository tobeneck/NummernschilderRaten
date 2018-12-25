import QtQuick 2.0

Text{
    id: highsoreText
    font.bold: true
    property var normalPixelSize: font.pixelSize

    function greenAndBigAnimation(){
        toGreen.start()
        toBigSize.start()
        return ""
    }

    function redAnimation(){
        toRed.start()
        return ""
    }

    ColorAnimation on color{
        id: toGreen
        to: "#008000" //green
        duration: 20
        onStopped: toBlack.start()
        running: false
    }
    ColorAnimation on color{
        id: toRed
        to: "#ff0000" //red
        duration: 20
        onStopped: toBlack.start()
        running: false
    }
    ColorAnimation on color{
        id: toBlack
        to: "black"
        duration: 2000
        running: false
    }
    NumberAnimation on font.pixelSize {
        id: toBigSize
        to: highsoreText.normalPixelSize * 1.5
        duration: 20
        onStopped: toNormalSize.start()
        running: false
    }
    NumberAnimation on font.pixelSize {
        id: toNormalSize
        to: highsoreText.normalPixelSize
        duration: 200
        running: false
    }
}
