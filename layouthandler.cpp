#include "layouthandler.h"
#include <QStandardPaths>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QTextStream>
#include <QDebug>
#include <QCoreApplication>
#include <algorithm>

LayoutManager::LayoutManager(QObject *parent)
    : QObject(parent)
{
}

void LayoutManager::applyLayout(const QString &layoutName)
{
    setStatusText("Applying " + layoutName + " layout...");

    if (copyLayoutFile(layoutName)) {
        setStatusText(layoutName + " layout applied successfully!");
        if (QProcess::execute("host-spawn", QStringList() << "plasmashell" << "--replace") != 0) {
            QProcess::execute("plasmashell", QStringList() << "--replace");
        }
        emit layoutChanged(true, layoutName);
    } else {
        setStatusText("Failed to apply " + layoutName + " layout");
        emit layoutChanged(false, layoutName);
    }
}


void LayoutManager::restoreBackup()
{
    setStatusText("Restoring backup layout...");

    QString sourcePath = getPlasmaConfigPath() + ".backup";
    QString targetPath = getPlasmaConfigPath();

    QFile backupFile(sourcePath);
    if (!backupFile.exists()) {
        setStatusText("No backup file found");
        emit layoutChanged(false, "Backup");
        return;
    }

    QFile::remove(targetPath);

    if (backupFile.copy(targetPath)) {
        setStatusText("Backup restored successfully!");
        if (QProcess::execute("host-spawn", QStringList() << "plasmashell" << "--replace") != 0) {
            QProcess::execute("plasmashell", QStringList() << "--replace");
        }
        emit layoutChanged(true, "Backup");
    } else {
        setStatusText("Failed to restore backup");
        emit layoutChanged(false, "Backup");
    }
}

void LayoutManager::setStatusText(const QString &text)
{
    if (m_statusText != text) {
        m_statusText = text;
        emit statusTextChanged();
    }
}

bool LayoutManager::copyLayoutFile(const QString &layoutName)
{
    QString sourcePath = getAssetsPath() + "/" + layoutName + "/plasma-org.kde.plasma.desktop-appletsrc";
    QString targetPath = getPlasmaConfigPath();
    QString backupPath = targetPath + ".backup";

    qDebug() << "Copying from:" << sourcePath;
    qDebug() << "Copying to:" << targetPath;

    QFile sourceFile(sourcePath);
    if (!sourceFile.exists()) {
        qDebug() << "Source file does not exist:" << sourcePath;
        return false;
    }

    QDir configDir(QFileInfo(targetPath).absolutePath());
    if (!configDir.exists()) {
        if (!configDir.mkpath(".")) {
            qDebug() << "Failed to create config directory:" << configDir.absolutePath();
        }
    }

    if (QFile::exists(targetPath)) {
        QFile::remove(backupPath);
        if (!QFile::copy(targetPath, backupPath)) {
            qDebug() << "Failed to create backup, but continuing...";
        }
    }

    if (!sourceFile.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Failed to open source file:" << sourcePath;
        return false;
    }
    QString content = QString::fromUtf8(sourceFile.readAll());
    sourceFile.close();

    // Strip lastScreen lines so panels don't all lock to screen 0 on multi-monitor
    QStringList lines = content.split('\n');
    lines.erase(std::remove_if(lines.begin(), lines.end(), [](const QString &line) {
        return line.trimmed().startsWith("lastScreen=");
    }), lines.end());
    content = lines.join('\n');

    QFile existingConfig(targetPath);
    if (existingConfig.exists() && existingConfig.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QString existingContent = QString::fromUtf8(existingConfig.readAll());
        existingConfig.close();

        int mappingStart = existingContent.indexOf(QStringLiteral("[ScreenMapping]"));
        if (mappingStart != -1) {
            int mappingEnd = existingContent.indexOf(QStringLiteral("\n["), mappingStart + 1);
            QString screenMapping;
            if (mappingEnd != -1)
                screenMapping = existingContent.mid(mappingStart, mappingEnd - mappingStart);
            else
                screenMapping = existingContent.mid(mappingStart);

            int newStart = content.indexOf(QStringLiteral("[ScreenMapping]"));
            if (newStart != -1) {
                int newEnd = content.indexOf(QStringLiteral("\n["), newStart + 1);
                if (newEnd != -1)
                    content = content.left(newStart) + screenMapping + content.mid(newEnd);
                else
                    content = content.left(newStart) + screenMapping;
            } else {
                content += QStringLiteral("\n") + screenMapping;
            }
        }
    }

    QFile::remove(targetPath);
    QFile targetFile(targetPath);
    if (targetFile.open(QIODevice::WriteOnly | QIODevice::Text)) {
        targetFile.write(content.toUtf8());
        targetFile.close();
        targetFile.setPermissions(targetFile.permissions() | QFileDevice::WriteOwner);
        qDebug() << "File written successfully to:" << targetPath;
        return true;
    } else {
        qDebug() << "Failed to write file:" << targetPath;
        return false;
    }
}

QString LayoutManager::getPlasmaConfigPath() const
{
    return QDir::homePath() + "/.config/plasma-org.kde.plasma.desktop-appletsrc";
}



QString LayoutManager::getAssetsPath() const
{
    QString appDir = QCoreApplication::applicationDirPath();
    return appDir + "/assets";
}
