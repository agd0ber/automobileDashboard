import QtQuick 2.15

ListModel {
    id: vehicleConfModel

    ListElement {
        name: "engineRPM"
        displaytext: "Engine RPM"
        value: 5000
        unit: ""
    }

    ListElement {
        name: "tyreRow"
        displaytext: "Tyre diameter"
        value: 680
        unit: "mm"
    }

    ListElement {
        name: "fGear"
        displaytext: "First gear ratio"
        value: 2.7
        unit: ""
    }

    ListElement {
        name: "sGear"
        displaytext: "Second gear ratio"
        value: 2.1
        unit: ""
    }

    ListElement {
        name: "tGear"
        displaytext: "Third gear ratio"
        value: 1.5
        unit: ""
    }

    ListElement {
        name: "fourGear"
        displaytext: "Fourth gear ratio"
        value: 1
        unit: ""
    }

    ListElement {
        name: "fiveGear"
        displaytext: "Fifth gear ratio"
        value: 0.85
        unit: ""
    }

    ListElement {
        name: "sixGear"
        displaytext: "Sixth gear ratio"
        value: 0.6
        unit: ""
    }

}
