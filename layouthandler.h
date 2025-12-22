#ifndef LAYOUTMANAGER_H
#define LAYOUTMANAGER_H

#include <QObject>
#include <QStandardPaths>
#include <QDir>
#include <QFile>
#include <QTextStream>
#include <QCoreApplication>
#include <QProcess>

class LayoutManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString statusText READ statusText WRITE setStatusText NOTIFY statusTextChanged)

public:
    explicit LayoutManager(QObject *parent = nullptr);

    Q_INVOKABLE void applyLayout(const QString &layoutName);

    QString statusText() const { return m_statusText; }
    void setStatusText(const QString &text);

signals:
    void statusTextChanged();
    void layoutChanged(bool success, const QString &layoutName);

private:
    QString m_statusText;
    bool copyLayoutFile(const QString &layoutName);
    QString getPlasmaConfigPath() const;
    QString getAssetsPath() const;
};

#endif // LAYOUTMANAGER_H