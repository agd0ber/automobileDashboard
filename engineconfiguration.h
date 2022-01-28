#ifndef ENGINECONFIGURATION_H
#define ENGINECONFIGURATION_H

#include <QObject>
#include <QVector>

class EngineConfiguration : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int engineRPM READ engineRPM WRITE setEngineRPM NOTIFY engineRPMChanged)
    Q_PROPERTY(int speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(double maxEngineRPM READ maxEngineRPM WRITE setMaxEngineRPM NOTIFY maxEngineRPMChanged)
    Q_PROPERTY(int curGear READ curGear WRITE setCurGear NOTIFY curGearChanged)

public:
    EngineConfiguration();

    void setEngineRPM (int temp);
    int engineRPM() const;
    void setSpeed (int temp);
    int speed() const;
    void setMaxEngineRPM (double temp);
    double maxEngineRPM() const;
    void setCurGear (int temp);
    int curGear() const;

    Q_INVOKABLE void accelerate(bool acc);
    Q_INVOKABLE void applyBrake(bool breaks);
    Q_INVOKABLE void updateEngineProp (QString param, double value);

signals:

    void engineRPMChanged();
    void speedChanged();
    void maxEngineRPMChanged();
    void curGearChanged();

public slots:
    void calculateSpeed();


private:
    int m_engineRPM;
    int m_speed;
    int m_curGear;
    double m_MaxEngineRPM;
    double m_tyreDiameter;
    double m_driveRatio;
    QVector <double> m_gearRatios;
    QVector <int> m_gearSpeeds;
    bool isAccelerating;
    bool isBraking;
};

#endif // ENGINECONFIGURATION_H
