#include "engineconfiguration.h"

EngineConfiguration::EngineConfiguration()
{

}

void EngineConfiguration::setEngineRPM (int temp) {
    if (temp > 0) {
        m_engineRPM = temp;
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
