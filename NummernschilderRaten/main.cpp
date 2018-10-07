#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QQuickView>

int main(int argc, char *argv[])
{
//    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard")); //virtual Keybord, TODO: delete

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    QQuickView checkLicencePlateView(QUrl::fromLocalFile("ckeckLicencePlate.qml"));
    QQuickItem *checkLicencePlateItem = checkLicencePlateView.rootObject();

    QQuickView guessLicencePlateView(QUrl::fromLocalFile("guessLicencePlate.qml"));
    QQuickItem *guessLicencePlateItem = guessLicencePlateView.rootObject();

//    MyClass myClass;
//    QObject::connect(item, SIGNAL(qmlSignal(QString)),
//                     &myClass, SLOT(cppSlot(QString)));

    QFontDatabase::addApplicationFont(":/../Fonts/EuroPlate.ttf");

    return app.exec();
}
