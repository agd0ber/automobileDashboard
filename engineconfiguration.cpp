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
    } else if (param.compare("tyreDiameter") == 0) {
        m_tyreDiameter = value;
    } else if (param.compare("firstGear") == 0) {
//        m_FirstGear = value;
    }
    else if (param.compare("driveRatio") == 0) {
            m_driveRatio = value;
    }
}

void EngineConfiguration::calculateSpeed()
{
    if (isAccelerating == true && m_engineRPM < maxEngineRPM()) {
        m_engineRPM = m_engineRPM + 50;
    } else if (isAccelerating == false && m_engineRPM > 0) {
        m_engineRPM = m_engineRPM - 50;
    }

    if(isBraking == true && isAccelerating == false) {
         m_engineRPM = m_engineRPM - 250;
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
