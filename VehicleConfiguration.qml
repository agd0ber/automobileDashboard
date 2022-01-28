import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQml.Models 2.15


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

                //                property string name: ""
                Text {
                    id: name
                    anchors.verticalCenter: parent.verticalCenter
                    width: settingPanel.width * 0.4
                    font.pointSize: 15
                    text: displayText
                }

                TextField {
                    id: valF
                    anchors.verticalCenter: parent.verticalCenter
                    width: settingPanel.width * 0.4
                    font.pointSize: 15
                    text: value
                    onTextChanged: {

                        for (var i = 0; i < vehicleConfModel.count; i++) {

                            if (vehicleConfModel.get(i).displayText === name.text) {
                                vehicleConfModel.setProperty(i, "value", parseFloat(text));
                            }
                        }
                    }
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    width: settingPanel.width * 0.4
                    font.pointSize: 15
                    text: unit
                }
            }
        }

        Button {
            id: updateButton
            text: "Update"
            width: settingPanel.width * 0.3
            height: width * 0.4
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                for (var i = 0; i < vehicleConfModel.count; i++) {
                    var pName = vehicleConfModel.get(i).name
                    var pValue = vehicleConfModel.get(i).value
                    engineConfigCPP.updateEngineProp(pName, pValue)

                }
            }
        }
    }
}
