#ifndef ENGINECONFIGURATION_H
#define ENGINECONFIGURATION_H

#include <QObject>

class EngineConfiguration : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int engineRPM READ engineRPM WRITE setEngineRPM NOTIFY engineRPMChanged)
    Q_PROPERTY(int speed READ speed WRITE setSpeed NOTIFY speedChanged)

public:
    EngineConfiguration();

    void setEngineRPM (int temp);
    int engineRPM() const;
    void setSpeed (int temp);
    int speed() const;

    Q_INVOKABLE void accelerate(bool acc);
    Q_INVOKABLE void applyBrake(bool breaks);
signals:

    void engineRPMChanged();
    void speedChanged();

private:
    int m_engineRPM;
    int m_speed;
    bool isAccelerating;
    bool isBraking;
};

#endif // ENGINECONFIGURATION_H
