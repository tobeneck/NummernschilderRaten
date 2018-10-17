#include "licenceplatedatabase.h"

#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QRandomGenerator>

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
    QString upperToken = token.toUpper();
    if(_data.contains(upperToken)){
        QVariant returnedValue;
        QMetaObject::invokeMethod(_qmlItem, "updateResultText",
                Q_RETURN_ARG(QVariant, returnedValue),
                Q_ARG(QVariant, _data[upperToken]));
    }
    else{
        QVariant returnedValue;
        QMetaObject::invokeMethod(_qmlItem, "updateResultText",
                Q_RETURN_ARG(QVariant, returnedValue),
                Q_ARG(QVariant, QString("keine gültige abkürzung")));
    }
}

void LicencePlateDatabase::guessToken() //BUG: there was a out of range exeption!
{
    //find real token
    QList<QString> tokens = _data.keys();
    int tokenPosition = QRandomGenerator::global()->bounded(tokens.count() - 1);
    QString realToken = tokens.at(tokenPosition);
    QString cityToLookFor = _data[realToken];

    //generate false answers
    QList<QString> falseAnsewers;
    for(int i = tokenPosition + 1; i < tokenPosition + 3 || i >= tokens.count() ; i++){
        falseAnsewers.append(tokens.at(i));
    }
    for(int i = tokenPosition - 1; i > tokenPosition - 3 || i <= 0 ; i--){
        falseAnsewers.append(tokens.at(i));
    }

    //filter false answers
    //NOTE: better Filters can be installed here
//    for(int i = 0; i < falseAnsewers.count() && falseAnsewers.count() <= 3; i++){ //sort for start letters
//        if(falseAnsewers.at(i).at(0) != realToken.at(0))
//            falseAnsewers.removeAt(i);
//    }
    for(int i = 0; i < falseAnsewers.count() && falseAnsewers.count() <= 3; i++){ //remove until just 3
        if(i%2 == 0)
            falseAnsewers.pop_back();
        else
            falseAnsewers.pop_front();
    }

    //randomize the output to the user
    int returnPattern = QRandomGenerator::global()->bounded(3);
    QVariant returnedValue;
    switch(returnPattern){
    case 0:
        QMetaObject::invokeMethod(_qmlItem, "setNewUserQuestion",
                  Q_RETURN_ARG(QVariant, returnedValue),
                  Q_ARG(QVariant, falseAnsewers.at(0)),
                  Q_ARG(QVariant, falseAnsewers.at(1)),
                  Q_ARG(QVariant, falseAnsewers.at(2)),
                  Q_ARG(QVariant, realToken),
                  Q_ARG(QVariant, 4),
                  Q_ARG(QVariant, _data[falseAnsewers.at(0)]),
                  Q_ARG(QVariant, _data[falseAnsewers.at(2)]),
                  Q_ARG(QVariant, _data[falseAnsewers.at(1)]),
                  Q_ARG(QVariant, _data[realToken]));
        break;
    case 1:
        QMetaObject::invokeMethod(_qmlItem, "setNewUserQuestion",
                  Q_RETURN_ARG(QVariant, returnedValue),
                  Q_ARG(QVariant, falseAnsewers.at(0)),
                  Q_ARG(QVariant, falseAnsewers.at(1)),
                  Q_ARG(QVariant, realToken),
                  Q_ARG(QVariant, falseAnsewers.at(2)),
                  Q_ARG(QVariant, 3),
                  Q_ARG(QVariant, _data[falseAnsewers.at(0)]),
                  Q_ARG(QVariant, _data[falseAnsewers.at(1)]),
                  Q_ARG(QVariant, _data[realToken]),
                  Q_ARG(QVariant, _data[falseAnsewers.at(2)]));
        break;
    case 2:
        QMetaObject::invokeMethod(_qmlItem, "setNewUserQuestion",
                  Q_RETURN_ARG(QVariant, returnedValue),
                  Q_ARG(QVariant, falseAnsewers.at(0)),
                  Q_ARG(QVariant, realToken),
                  Q_ARG(QVariant, falseAnsewers.at(1)),
                  Q_ARG(QVariant, falseAnsewers.at(2)),
                  Q_ARG(QVariant, 2),
                  Q_ARG(QVariant, _data[falseAnsewers.at(0)]),
                  Q_ARG(QVariant, _data[realToken]),
                  Q_ARG(QVariant, _data[falseAnsewers.at(1)]),
                  Q_ARG(QVariant, _data[falseAnsewers.at(2)]));
        break;
    case 3:
        QMetaObject::invokeMethod(_qmlItem, "setNewUserQuestion",
                  Q_RETURN_ARG(QVariant, returnedValue),
                  Q_ARG(QVariant, realToken),
                  Q_ARG(QVariant, falseAnsewers.at(0)),
                  Q_ARG(QVariant, falseAnsewers.at(1)),
                  Q_ARG(QVariant, falseAnsewers.at(2)),
                  Q_ARG(QVariant, 1),
                  Q_ARG(QVariant, _data[realToken]),
                  Q_ARG(QVariant, _data[falseAnsewers.at(0)]),
                  Q_ARG(QVariant, _data[falseAnsewers.at(1)]),
                  Q_ARG(QVariant, _data[falseAnsewers.at(2)]));
        break;
    }
}

void LicencePlateDatabase::readFile()
{
    QFile file(":/NummernschilderDaten/Nummernschilder"); //no qrc:/ in this case, don't know why...
    if (!file.open(QIODevice::ReadOnly)){
        qDebug() << "could not open file with Error: " + file.errorString();
        return;
    }

    QTextStream in(&file);
    while (!in.atEnd()) {
        QString line = in.readLine();
        QStringList splitLine = line.split("\t"); // \t = tab

        if(splitLine.count() >= 3){
            _data[splitLine.at(0)] = splitLine.at(1) + ", \n" + splitLine.at(2);
        }
        else if(splitLine.count() == 2){
            _data[splitLine.at(0)] = splitLine.at(1);
        }
        else{
            qDebug() << "something went wrong reading the data file!";
        }

    }
}
