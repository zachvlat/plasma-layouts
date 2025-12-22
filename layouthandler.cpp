#include "layouthandler.h"
#include <QStandardPaths>
#include <QDir>
#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QCoreApplication>

LayoutManager::LayoutManager(QObject *parent)
    : QObject(parent)
{
}

void LayoutManager::applyLayout(const QString &layoutName)
{
    setStatusText("Applying " + layoutName + " layout...");
    
    if (copyLayoutFile(layoutName)) {
        setStatusText(layoutName + " layout applied successfully!");
        emit layoutChanged(true, layoutName);
    } else {
        setStatusText("Failed to apply " + layoutName + " layout");
        emit layoutChanged(false, layoutName);
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
    
    // Create config directory if it doesn't exist
    QDir configDir(QFileInfo(targetPath).absolutePath());
    if (!configDir.exists()) {
        if (!configDir.mkpath(".")) {
            qDebug() << "Failed to create config directory:" << configDir.absolutePath();
        }
    }
    
    // Create backup of current config
    if (QFile::exists(targetPath)) {
        QFile::remove(backupPath);
        if (!QFile::copy(targetPath, backupPath)) {
            qDebug() << "Failed to create backup, but continuing...";
            // Don't fail the operation, just log the issue
        }
    }
    
    QFile::remove(targetPath); // Remove existing file
    
    if (sourceFile.copy(targetPath)) {
        QFile targetFile(targetPath);
        if (targetFile.exists()) {
            targetFile.setPermissions(targetFile.permissions() | QFileDevice::WriteOwner);
            qDebug() << "File copied successfully to:" << targetPath;
            return true;
        } else {
            qDebug() << "File copy reported success but target doesn't exist:" << targetPath;
        }
    } else {
        qDebug() << "Failed to copy file from" << sourcePath << "to" << targetPath;
    }
    
    return false;
}

QString LayoutManager::getPlasmaConfigPath() const
{
    // Force home directory config path, ignoring Flatpak sandbox
    return QDir::homePath() + "/.config/plasma-org.kde.plasma.desktop-appletsrc";
}



QString LayoutManager::getAssetsPath() const
{
    QString appDir = QCoreApplication::applicationDirPath();
    // For Flatpak, assets are in /app/bin/assets
    return appDir + "/assets";
}