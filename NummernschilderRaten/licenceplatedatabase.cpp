#include "licenceplatedatabase.h"

#include <QFile>
#include <QTextStream>
#include <QDebug>

LicencePlateDatabase::LicencePlateDatabase(QObject *qmlItem)
{
    _qmlItem = qmlItem;

    this->readFile();
}

LicencePlateDatabase::~LicencePlateDatabase()
{
    delete _qmlItem;
}

void LicencePlateDatabase::checkToken(QString token)
{
    token = token.toUpper();
    if(_data.contains(token)){
        QVariant returnedValue;
        QMetaObject::invokeMethod(_qmlItem, "updateResultText",
                Q_RETURN_ARG(QVariant, returnedValue),
                Q_ARG(QVariant, _data[token]));
    }
    else{
        QVariant returnedValue;
        QMetaObject::invokeMethod(_qmlItem, "updateResultText",
                Q_RETURN_ARG(QVariant, returnedValue),
                Q_ARG(QVariant, QString("keine gültige abkürzung")));
    }
}

void LicencePlateDatabase::readFile()
{
    // /home/tobias/QT_Projects/NummernschilderRaten.git/NummernschilderDaten/Nummernschilder
    QFile file(":/NummernschilderDaten/Nummernschilder"); // qrc:/../NummernschilderDaten/kennzeichen.csv
    if (!file.open(QIODevice::ReadOnly)){
        qDebug() << "could not open file with Error: " + file.errorString();
        return;
    }

    QTextStream in(&file);
    while (!in.atEnd()) {
        QString line = in.readLine();
        QStringList splitLine = line.split("\t"); // \t = tab

        if(splitLine.length() >= 3){
            _data[splitLine.at(0)] = splitLine.at(1) + ", \n" + splitLine.at(2);
        }
        else if(splitLine.length() == 2){
            _data[splitLine.at(0)] = splitLine.at(1);
        }
        else{
            qDebug() << "something went wrong reading the data file!";
        }

    }
}
