#ifndef QMLCPPBRIDGE_H
#define QMLCPPBRIDGE_H

#include <QObject>
#include <QDebug>

class QmlCppBridge : public QObject
{
    Q_OBJECT
public:
    explicit QmlCppBridge(QObject *parent = nullptr);

    Q_INVOKABLE static void printHello() {
        qDebug() << "Hello, QML!";
    }

signals:

};

#endif // QMLCPPBRIDGE_H
