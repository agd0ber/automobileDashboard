import QtQuick 2.15

Item {
    id: valueSource

    property real speed: speedometer.value

    property string gear: {
        var gearValue

        if (speed == 0)
        {
            return "P"
        }
        else if (speed < 30)
        {
            return "1"
        }
        else if (speed < 50)
        {
            return "2"
        }
        else if (speed < 80)
        {
            return "3"
        }
        else if (speed < 120)
        {
            return "4"
        }
        else if (speed < 160)
        {
            return "5"
        }
        else
        {
            return "6"
        }

    }

}
