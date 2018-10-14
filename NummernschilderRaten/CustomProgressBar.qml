import QtQuick 2.0
import QtQuick.Controls 2.4


    ProgressBar {
        id: progressBar
        from: 0
        to: 3000
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
    }


