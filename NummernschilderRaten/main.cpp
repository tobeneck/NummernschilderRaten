#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QQuickItem>
#include <QQuickView>
#include <QObject>

#include "licenceplatedatabase.h"

int main(int argc, char *argv[])
{
//    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard")); //virtual Keybord, TODO: delete

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    QObject *qmlItem = engine.rootObjects().first();

    LicencePlateDatabase licenceplatedatabase(qmlItem);

    QObject::connect(qmlItem, SIGNAL(check(QString)), &licenceplatedatabase, SLOT(checkToken(QString)));

    QFontDatabase::addApplicationFont("qrc:/Fonts/EuroPlate.ttf");

    return app.exec();
}
