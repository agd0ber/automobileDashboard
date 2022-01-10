import QtQuick 2.15
import QtQuick.Controls.Styles 1.4

CircularGaugeStyle
{    // QtQuick.Controls.Styles
    id: rpmMeterStyle

    function degree2Rad (deg) {
        return deg * (Math.PI / 180);
    }

    labelStepSize: 1000
    background: Canvas {  //Qt Quick

        Row { //Qt Quick
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: outerRadius * 0.2

            Text {
                id: unitSpeed
                text: "RPM"
                color: "white"
                font.pixelSize: outerRadius * 0.1
            }
        }
    }

    tickmark: Rectangle { //Qt Quick
        visible: styleData.value % 100 == 0 // большое деление отображается с шагом 100
        implicitWidth: outerRadius * 0.02
        antialiasing: true //сглажвание
        implicitHeight: outerRadius * 0.06
        color: "#e5e5e5"
    }

    needle: Rectangle { //Qt Quick
        y: outerRadius * 0.15
        implicitWidth: outerRadius * 0.03
        implicitHeight: outerRadius * 0.9
        antialiasing: true
        color: "#e5e5e5"
    }

    foreground: Item{ //Qt Quick
        Rectangle { //Qt Quick
            width: outerRadius * 0.2
            height: width
            radius: width / 2
            color: "blue"
            anchors.centerIn: parent
        }
    }
}
