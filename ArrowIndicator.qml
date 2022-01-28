import QtQuick 2.15

Item {

    property int direction : Qt.LeftArrow
    property bool on : false
    property bool blinking : false

    scale: direction === Qt.LeftArrow ? 1 : -1

    function drawArrow(ctr) {
//        console.log("hi,paint");
        ctr.beginPath();
        ctr.moveTo(0, height * 0.5)
        ctr.lineTo(0.6 * width, 0)
        ctr.lineTo(0.6 * width, 0.28 * height)
        ctr.lineTo(width, 0.28 * height)
        ctr.lineTo(width, 0.72 * height)
        ctr.lineTo(0.6 * width, 0.72 * height)
        ctr.lineTo(0.6 * width, height)
        ctr.lineTo(0, height * 0.5)
    }

    Timer {
        id: indicatorTime
        interval: 3000
        running: on  //запуск таймера
        repeat: false
        onTriggered: on = false //выполняется, когда интервал таймера вышел
    }

    Timer {
        id: blinkingTimer
        interval: 500
        running: on
        repeat: true
        onTriggered: blinking = !blinking
    }

    Canvas {
        id: background
        anchors.fill: parent //полностью заполняет родительский виждет

        onPaint: {
//            console.log("hi,arrow");
            var ctr = getContext("2d")
            ctr.reset()

            drawArrow(ctr)
            ctr.lineWidth = 1
            ctr.strokeStyle = "white"
            ctr.stroke()

        }
    }

    Canvas {
        id: foreground
        anchors.fill: parent //полностью заполняет родительский виждет
        visible: on && blinking

        onPaint: {
            var ctr = getContext("2d")
            ctr.reset()

            drawArrow(ctr)
            ctr.fillStyle = "green"
            ctr.fill()
        }
    }

}
