#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "engineconfiguration.h"

int main(int argc, char *argv[])
{
//    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));  //строка включает виртуальную клавиатуру

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    EngineConfiguration *confptr = new EngineConfiguration(); //объект свойств, определяемых в модели С++

    QQmlApplicationEngine engine;


    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.load(url);

    QQmlContext * rootContext = engine.rootContext();

        qmlRegisterType<QmlCppBridge>("QmlCppBridge", 1, 0, "QmlCppBridge");

    rootContext->setContextProperty("engineConfigCPP", confptr); //связываем указатель на объект свойств и имя свойства в QML

    return app.exec();
}
