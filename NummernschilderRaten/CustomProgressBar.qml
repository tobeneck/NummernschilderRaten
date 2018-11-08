import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4


    ProgressBar {
        id: progressBar


        minimumValue: 0
        maximumValue: 3000
        value: 0

        function start() {
            timer.start()
        }
        function stop() {
            timer.stop()
            progressBar.value = 0
        }

        Timer{
            id: timer
            interval: 500
            repeat: true
            onTriggered: {
                progressBar.value += 500
            }
        }

        style: ProgressBarStyle {
            background: Rectangle {
                radius: settings.defaultRectRadius/5
                color: "lightgray"
                implicitWidth: progressBar.width - settings.defaultAnchorMargins * 2
                implicitHeight: settings.defaultAnchorMargins*2
            }
            progress: Rectangle {
                color: "#1f499c"
                radius: settings.defaultRectRadius/5
            }
        }
    }


