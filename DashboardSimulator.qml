import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.VirtualKeyboard 2.15
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4

Item {
    ValueSource {
        id: valueSource
    }

    Rectangle {     //Qt Quick
        id: dashboard
        anchors.centerIn: parent
        height: 500
        width: 1000
        color: "black"
        Row {
            id: dashboardRow
            spacing: dashboard.width * 0.02
            anchors.centerIn: parent

            ArrowIndicator {
                id: leftIndicator
                anchors.verticalCenter: parent.verticalCenter
                height: dashboard.height * 0.2 - dashboardRow.spacing
                width: height
                direction: Qt.LeftArrow
            }

            CircularGauge{
                id: rpmMeter
                width: height //300
                height: dashboard.height * 0.6 //300
                maximumValue: 5000

                style: RpmMeterStyle {}
            }

            CircularGauge{      // QtQuick.Extras
                id: speedometer

                property bool acceleration: false

                value: acceleration ? maximumValue : 0
                width: height //300
                height: dashboard.height * 0.6 //300
                maximumValue: 180

                style: SpeedometerStyle {}

                Behavior on value {     //Qt Quick
                    NumberAnimation{
                        duration: 5000
                    }
                }

                Component.onCompleted: forceActiveFocus(); //Qt Quick
            }

            ArrowIndicator {
                id: rightIndicator
                anchors.verticalCenter: parent.verticalCenter
                height: dashboard.height * 0.2 - dashboardRow.spacing
                width: height
                direction: Qt.RightArrow
            }
        }

        Keys.onUpPressed: {      //Qt Quick
            speedometer.acceleration = true
        }

        Keys.onReleased: {       //Qt Quick
            if (event.key === Qt.Key_Up) {
                speedometer.acceleration = false
                event.accepted = true
            }
        }

        Keys.onLeftPressed: {
            leftIndicator.on = true
            rightIndicator.on = false
        }

        Keys.onRightPressed: {
            rightIndicator.on = true
            leftIndicator.on = false
        }

    }
}
