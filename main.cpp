#include <QApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include "layouthandler.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // Set application icon
    app.setWindowIcon(QIcon(QIcon::fromTheme("org.kde.plasmalayouts")));

    qmlRegisterType<LayoutManager>("plasma_layouts", 1, 0, "LayoutManager");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("plasma_layouts", "Main");

    return app.exec();
}
