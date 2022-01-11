import QtQuick 2.15
import QtQuick.Controls 1.4

Item {
    id: rootComp

    VehicleConfModel {
        id: vehicleConfModel
    }

    Column {
        id: settingPanel
        width: parent.width
        anchors.centerIn: parent
        spacing: 10

        Repeater {
            id: parameterRepeater
            model: vehicleConfModel

            Row {
                id: repeaterRow
                spacing: 10

                property string name : ""

                Text {
                    id: name
                    anchors.verticalCenter: parent.verticalCenter
                    width: settingPanel.width * 0.4
                    font.pointSize: 15
                    text: displaytext
                }

                TextField {
                    anchors.verticalCenter: parent.verticalCenter
                    width: settingPanel.width * 0.4
                    font.pointSize: 15
                    text: value
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    width: settingPanel.width * 0.4
                    font.pointSize: 15
                    text: unit
                }
            }


        }
    }
}
// Не используется, отображение без репитера
//        SettingField {
//            id: rpmRow
//            name: "Maximum RPM"
//        }

//        SettingField {
//            id: tyreRow
//            name: "Type diameter"

//            Text {
//                id: tyreUnit
//                anchors.verticalCenter: parent.verticalCenter
//                width: settingPanel.width * 0.4
//                font.pointSize: 15
//                text: "mm"
//            }
//        }


//        SettingField {
//            id: fGear
//            name: "First gear ratio"
//        }

//        SettingField {
//            id: sGear
//            name: "Second gear ratio"
//        }

//        SettingField {
//            id: tGear
//            name: "Third gear ratio"
//        }

//        SettingField {
//            id: fourGear
//            name: "Fourth gear ratio"
//        }

//        SettingField {
//            id: fiveGear
//            name: "Fifth gear ratio"
//        }

//        SettingField {
//            id: sixGear
//            name: "Sixth gear ratio"
//        }
//    }


