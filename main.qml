import QtQuick 2.15
import QtQuick.Window 2.15
//import QtQuick.VirtualKeyboard 2.15
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 1.4

Window { //QtQuick.Window
    id: window
    width: 900
    height: 600
    visible: true
    title: qsTr("Automobile Dashboard")


    Column { //Qt Quick
        id: leftPanel
        anchors.left: parent.left
        anchors.top: parent. top

        width: parent * 0.2

        Button { //QtQuick.Controls
            id: configButton
            text: "Vehicle Configuration"

            onClicked: {
                centralPanelLoader.source = "VehicleConfiguration.qml"
            }

        }

        Button { //QtQuick.Controls
            id: simButton
            text: "Dashboard Simulation"

            onClicked: {
                centralPanelLoader.source = "DashboardSimulator.qml"
            }
        }
    }

    Loader { //Qt Quick
        id: centralPanelLoader
        anchors.centerIn: parent
        width: parent.width
    }

}
