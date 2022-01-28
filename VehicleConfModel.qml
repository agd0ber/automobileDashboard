import QtQuick 2.0
import QtQml.Models 2.15

ListModel {
    id: vehicleConfMod

    ListElement {
        name: "engineRPM"
        displayText: "Engine RPM"
        value: 3000
        unit: ""
    }

    ListElement {
        name: "driveRatio"
        displayText: "Final Drive ratio"
        value: 3.4
        unit: ""
    }

    ListElement {
        name: "tyreRow"
        displayText: "Tyre diameter"
        value: 680
        unit: "mm"
    }

    ListElement {
        name: "fGear"
        displayText: "First gear ratio"
        value: 2.7
        unit: ""
    }

    ListElement {
        name: "sGear"
        displayText: "Second gear ratio"
        value: 2.1
        unit: ""
    }

    ListElement {
        name: "tGear"
        displayText: "Third gear ratio"
        value: 1.5
        unit: ""
    }

    ListElement {
        name: "fourGear"
        displayText: "Fourth gear ratio"
        value: 1
        unit: ""
    }

    ListElement {
        name: "fiveGear"
        displayText: "Fifth gear ratio"
        value: 0.85
        unit: ""
    }

    ListElement {
        name: "sixGear"
        displayText: "Sixth gear ratio"
        value: 0.6
        unit: ""
    }
}
