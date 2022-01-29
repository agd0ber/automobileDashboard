#include <QTimer>

#include "engineconfiguration.h"

EngineConfiguration::EngineConfiguration()
{
    m_speed = 0;

    m_MaxEngineRPM = 4000;
    m_driveRatio = 3.4;
    m_tyreDiameter = 680;

    m_curGear = 1;
    m_gearRatios.append(2.97);
    m_gearRatios.append(2.07);
    m_gearRatios.append(1.43);
    m_gearRatios.append(1);
    m_gearRatios.append(0.84);
    m_gearRatios.append(0.56);

    m_gearSpeeds.append(5);
    m_gearSpeeds.append(37);
    m_gearSpeeds.append(54);
    m_gearSpeeds.append(78);
    m_gearSpeeds.append(111);
    m_gearSpeeds.append(132);

    isAccelerating = false;
    isBraking = false;

    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &EngineConfiguration::calculateSpeed);
    timer->start(100);

}

void EngineConfiguration::setEngineRPM (int temp) {
    if (temp > 0) {
        m_engineRPM = temp;
        //emit maxEngineRPMChanged();
    }
}

int EngineConfiguration::engineRPM() const {
    return m_engineRPM;
}

void EngineConfiguration::setSpeed (int temp) {
    if (temp > 0) {
        m_speed = temp;
    }
}

int EngineConfiguration::speed() const {
    return m_speed;
}

void EngineConfiguration::setMaxEngineRPM (double temp) {
    if (temp > 0.0) {
        m_MaxEngineRPM = temp;
        emit maxEngineRPMChanged();
    }
}

double EngineConfiguration::maxEngineRPM() const {
    return m_MaxEngineRPM;
}

void EngineConfiguration::setCurGear(int temp)
{
    if (temp > 0) {
        m_curGear = temp;
    }
}

int EngineConfiguration::curGear() const
{
    return m_curGear;
}

void EngineConfiguration::accelerate(bool acc){
    if (acc) {
        isBraking = false;
        isAccelerating = true;
        emit speedChanged();
        emit engineRPMChanged();
    }
    else {
        isAccelerating = false;
        emit speedChanged();
        emit engineRPMChanged();
    }
}

void EngineConfiguration::applyBrake(bool brakes){
    if (brakes) {
        isBraking = true;
        isAccelerating = false;
        emit speedChanged();
        emit engineRPMChanged();
    }
    else {
        isBraking = false;
        emit speedChanged();
        emit engineRPMChanged();
    }
}

void EngineConfiguration::updateEngineProp (QString param, double value) {
    if(param.compare("engineRPM") == 0) {
        m_MaxEngineRPM = value;
        emit maxEngineRPMChanged();
    }
    else if (param.compare("driveRatio") == 0) m_driveRatio = value;
    else if (param.compare("tyreRow") == 0) m_tyreDiameter = value;
    else if (param.compare("fGear") == 0) m_gearRatios[0] = value;
    else if (param.compare("sGear") == 0) m_gearRatios[1] = value;
    else if (param.compare("tGear") == 0) m_gearRatios[2] = value;
    else if (param.compare("fourGear") == 0) m_gearRatios[3] = value;
    else if (param.compare("fiveGear") == 0) m_gearRatios[4] = value;
    else if (param.compare("sixGear") == 0) m_gearRatios[5] = value;

}

double EngineConfiguration::getEngineProperty(QString param)
{
    if (param.compare("engineRPM") == 0) return m_MaxEngineRPM;
    else if (param.compare("driveRatio") == 0) return m_driveRatio;
    else if (param.compare("tyreRow") == 0) return m_tyreDiameter;
    else if (param.compare("fGear") == 0) return m_gearRatios.at(0);
    else if (param.compare("sGear") == 0) return m_gearRatios.at(1);
    else if (param.compare("tGear") == 0) return m_gearRatios.at(2);
    else if (param.compare("fourGear") == 0) return m_gearRatios.at(3);
    else if (param.compare("fiveGear") == 0) return m_gearRatios.at(4);
    else if (param.compare("sixGear") == 0) return m_gearRatios.at(5);

}

void EngineConfiguration::calculateSpeed()
{
    if (isAccelerating == true && m_engineRPM < maxEngineRPM()) {
        m_engineRPM = m_engineRPM + 50;
    } else if (isAccelerating == false && m_engineRPM > 0) {
        m_engineRPM = m_engineRPM - 50;
    }

    if(isBraking == true && isAccelerating == false) {
         m_engineRPM = m_engineRPM - 150;
    }

    if (isAccelerating == true && m_engineRPM > 3000){ //upshifting the gear
        if (m_curGear < 6) {
            m_curGear++;
        }
        m_engineRPM = m_speed * (30 * m_gearRatios[m_curGear - 1] * m_driveRatio) / (3.6 *  3.14 * (m_tyreDiameter/(2 * 1000)));
    }

    if (isAccelerating == false) { //downshifting the gear
        if (m_curGear > 0) {
            if (m_speed < m_gearSpeeds.at(m_curGear - 1)) {
                m_curGear--;
                if (m_curGear < 1) {
                    m_curGear = 1;
                }
                m_engineRPM = m_speed * (30 * m_gearRatios[m_curGear - 1] * m_driveRatio) / (3.6 *  3.14 * (m_tyreDiameter/(2 * 1000)));
            }
        }
    }
    m_speed = 3.6 * m_engineRPM * 3.14 * (m_tyreDiameter/(2 * 1000)) / (30 * m_gearRatios[m_curGear - 1] * m_driveRatio);
    emit speedChanged();
    emit engineRPMChanged();
    emit curGearChanged();
}
