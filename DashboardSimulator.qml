import QtQuick 2.0
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

    Rectangle {
        //Qt Quick
        id: dashboard
        anchors.centerIn: parent
        height: 500
        width: 1000
        color: "black"
        Row {
            //Qt Quick
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

            CircularGauge {
                // QtQuick.Extras
                id: rpmMeter
                value: engineConfigCPP.engineRPM
                width: height //300
                height: dashboard.height * 0.6 //300
                maximumValue: engineConfigCPP.maxEngineRPM

                style: RpmMeterStyle {}
            }

            CircularGauge {
                // QtQuick.Extras
                id: speedometer

                property bool acceleration: false

                value: engineConfigCPP.speed
                width: height //300
                height: dashboard.height * 0.6 //300
                maximumValue: 180

                style: SpeedometerStyle {}

                Component.onCompleted: forceActiveFocus() //Qt Quick
            }

            ArrowIndicator {
                id: rightIndicator
                anchors.verticalCenter: parent.verticalCenter
                height: dashboard.height * 0.2 - dashboardRow.spacing
                width: height
                direction: Qt.RightArrow
            }
        }

        Keys.onUpPressed: {
            //Qt Quick
            engineConfigCPP.accelerate(true)
            engineConfigCPP.applyBrake(false)
            //speedometer.acceleration = true
        }

        Keys.onDownPressed: {
            engineConfigCPP.applyBrake(true)
            engineConfigCPP.accelerate(false)
        }

        Keys.onReleased: {
            //Qt Quick
            if (event.key === Qt.Key_Up) {
                engineConfigCPP.accelerate(false)
                //  speedometer.acceleration = false
                event.accepted = true
            } else if (event.key === Qt.Key_Down) {
                engineConfigCPP.applyBrake(false)
                event.accepted = true
            }
        }

        Keys.onLeftPressed: {
            //Qt Quick
            leftIndicator.on = true
            rightIndicator.on = false
        }

        Keys.onRightPressed: {
            //Qt Quick
            rightIndicator.on = true
            leftIndicator.on = false
        }
    }
}
