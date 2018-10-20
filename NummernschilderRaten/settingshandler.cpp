#include <QSettings>

#include "settingshandler.h"


SettingsHandler::SettingsHandler()
{
    QSettings settings("PlateSoft", "KennzeichenRaten");
    if(!settings.contains("settingsWritten")){
        //settings->setValue("settingsWritten", true);
        settings.setValue("licencePlateImageRatio", 0.25107604017);
        settings.setValue("defaultAnchorMargins", 5);
    }
}
