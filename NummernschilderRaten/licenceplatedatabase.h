#ifndef LICENCEPLATEDATABASE_H
#define LICENCEPLATEDATABASE_H

#include <QMap>
#include <QObject>
#include <QQuickItem>

class LicencePlateDatabase : public QObject
{
    Q_OBJECT
public:
    LicencePlateDatabase(QObject *qmlItem);
    ~LicencePlateDatabase();

public slots:
    void checkToken(QString token);
    void guessToken();

private:
    void readFile();

private:
    QMap<QString, QString> _data;

    QObject *_qmlItem;
};

#endif // LICENCEPLATEDATABASE_H
