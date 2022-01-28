import QtQuick 2.15
import QtQuick.Controls.Styles 1.4

CircularGaugeStyle
{    // QtQuick.Controls.Styles
    id: speedometerStyle

    function degree2Rad (deg) {
        return deg * (Math.PI / 180);
    }

    background: Canvas {  //Qt Quick
        onPaint: {
            var ctr = getContext("2d");
            ctr.reset();
            ctr.beginPath();

            ctr.strokeStyle = "red";
            ctr.linewidth = outerRadius * 0.02;

            ctr.arc(outerRadius, outerRadius, outerRadius - ctr.lineWidth / 2,
                    degree2Rad(valueToAngle(120) - 90), degree2Rad(valueToAngle(180) - 90));
            ctr.stroke();
        }

        Row { //Qt Quick
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: outerRadius * 0.2

            Text {
                id: speedText
                text: kphValue
                color: "white"
                font.pixelSize: outerRadius * 0.1
                horizontalAlignment: Text.AlignRight

                readonly property int kphValue : engineConfigCPP.speed            }

            Text {
                id: unitSpeed
                text: " km/h"
                color: "white"
                font.pixelSize: outerRadius * 0.1
            }
        }

        Text {
            id: gearText
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: outerRadius * 0.4

            color: "white"
            font.pixelSize: outerRadius * 0.3

            text: gear

            readonly property string gear : valueSource.gear
        }
    }

    tickmark: Rectangle { //Qt Quick
        visible: true// video suggests to use "styleData.value < 120 || styleData.value % 10 == 0". Rationale?
        implicitWidth: outerRadius * 0.02
        antialiasing: true //сглажвание
        implicitHeight: outerRadius * 0.06
        color: styleData.value >= 120 ? "#e34c22" : "#e5e5e5"
    }

    minorTickmark: Rectangle { //Qt Quick
        implicitWidth: outerRadius * 0.01
        antialiasing: true //сглажвание
        implicitHeight: outerRadius * 0.03
        color: styleData.value >= 120 ? "#e34c22" : "#e5e5e5"
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
