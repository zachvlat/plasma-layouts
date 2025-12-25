import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Dialogs
import plasma_layouts

ApplicationWindow {
    id: window
    width: 1400
    height: 900
    visible: true
    title: qsTr("Plasma Layout Manager")
    color: palette.window

    property real cardRadius: 12
    property real cardPadding: 24
    property real spacing: 30
    property bool layoutApplied: false
    property string appliedLayout: ""
    property int columns: window.width < 800 ? 1 : window.width < 1200 ? 2 : 4

    LayoutManager {
        id: layoutManager
        onLayoutChanged: function(success, layoutName) {
            if (success) {
                layoutApplied = true
                appliedLayout = layoutName
                logoutDialog.open()
            } else {
                errorDialog.open()
            }
        }
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            Action {
                text: qsTr("Exit")
                onTriggered: Qt.quit()
            }
        }
        Menu {
            title: qsTr("Help")
            Action {
                text: qsTr("About")
                onTriggered: aboutDialog.open()
            }
        }
    }

    ScrollView {
        id: scrollView
        anchors.fill: parent
        anchors.margins: window.width < 600 ? 16 : 24
        contentWidth: availableWidth
        
        // Enable smooth scrolling
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        ScrollBar.vertical.interactive: true
        
        // Ensure content can expand
        contentHeight: mainLayout.implicitHeight

        ColumnLayout {
            id: mainLayout
            width: parent.width
            spacing: window.width < 600 ? 15 : window.spacing
            
            // Ensure the layout can expand beyond viewport
            implicitHeight: childrenRect.height

            // Header
            ColumnLayout {
                Layout.fillWidth: true
                spacing: 8

                Text {
                    text: "Plasma Layout Manager"
                    font.pixelSize: window.width < 600 ? 22 : 28
                    font.bold: true
                    font.family: "Segoe UI, sans-serif"
                    color: palette.text
                    Layout.alignment: Qt.AlignHCenter
                }

                Text {
                    text: "Choose your preferred desktop layout"
                    font.pixelSize: window.width < 600 ? 12 : 14
                    color: palette.text
                    opacity: 0.7
                    Layout.alignment: Qt.AlignHCenter
                }
            }

            // Layout Cards Grid
            GridLayout {
                id: cardGrid
                Layout.fillWidth: true
                Layout.topMargin: window.width < 600 ? 10 : 20
                Layout.preferredHeight: implicitHeight
                columns: window.columns
                rowSpacing: window.spacing
                columnSpacing: window.spacing

                LayoutCard {
                    Layout.fillWidth: true
                    Layout.preferredHeight: window.width < 600 ? 200 : window.width < 1200 ? 280 : 320
                    layoutName: "Cosmic"
                    layoutIcon: "🚀"
                    layoutDescription: "Modern space-themed desktop with cosmic aesthetics"
                    onApplyClicked: layoutManager.applyLayout("Cosmic")
                }

                LayoutCard {
                    Layout.fillWidth: true
                    Layout.preferredHeight: window.width < 600 ? 200 : window.width < 1200 ? 280 : 320
                    layoutName: "Ubuntu"
                    layoutIcon: "🌍"
                    layoutDescription: "Classic Ubuntu-style dock and panel layout"
                    onApplyClicked: layoutManager.applyLayout("Ubuntu")
                }

                LayoutCard {
                    Layout.fillWidth: true
                    Layout.preferredHeight: window.width < 600 ? 200 : window.width < 1200 ? 280 : 320
                    layoutName: "Redmond"
                    layoutIcon: "🪟"
                    layoutDescription: "Windows 11 inspired taskbar and start menu"
                    onApplyClicked: layoutManager.applyLayout("Redmond")
                }

                LayoutCard {
                    Layout.fillWidth: true
                    Layout.preferredHeight: window.width < 600 ? 200 : window.width < 1200 ? 280 : 320
                    layoutName: "WM"
                    layoutIcon: "⚡"
                    layoutDescription: "Window manager focused minimal layout"
                    onApplyClicked: layoutManager.applyLayout("WM")
                }
                LayoutCard {
                    Layout.fillWidth: true
                    Layout.preferredHeight: window.width < 600 ? 200 : window.width < 1200 ? 280 : 320
                    layoutName: "Windows"
                    layoutIcon: "🪟"
                    layoutDescription: "Windows Like"
                    onApplyClicked: layoutManager.applyLayout("Windows")
                }
                LayoutCard {
                    Layout.fillWidth: true
                    Layout.preferredHeight: window.width < 600 ? 200 : window.width < 1200 ? 280 : 320
                    layoutName: "NeoCosmic"
                    layoutIcon: "☄️"
                    layoutDescription: "Cosmic Like"
                    onApplyClicked: layoutManager.applyLayout("NeoCosmic")
                }
                LayoutCard {
                    Layout.fillWidth: true
                    Layout.preferredHeight: window.width < 600 ? 200 : window.width < 1200 ? 280 : 320
                    layoutName: "Macos"
                    layoutIcon: "🍎"
                    layoutDescription: "MacOS Like"
                    onApplyClicked: layoutManager.applyLayout("Macos")
                }
            }


        }
    }

    // Logout Dialog
    Dialog {
        id: logoutDialog
        title: qsTr("Layout Applied Successfully")
        modal: true
        standardButtons: Dialog.Ok
        width: 450
        height: 180
        x: (window.width - width) / 2
        y: (window.height - height) / 2

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 20
            width: parent.width - 40

            Text {
                text: qsTr("The %1 layout has been applied successfully.\n\nPlease logout and login again for the changes to take effect.").arg(appliedLayout)
                wrapMode: Text.WordWrap
                font.pixelSize: 14
                color: palette.text
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
            }
        }
    }

    // Error Dialog
    Dialog {
        id: errorDialog
        title: qsTr("Error")
        modal: true
        standardButtons: Dialog.Ok
        width: 450
        height: 180
        x: (window.width - width) / 2
        y: (window.height - height) / 2

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 20
            width: parent.width - 40

            Text {
                text: qsTr("Failed to apply the selected layout.\n\nPlease check if the layout files exist and try again.")
                wrapMode: Text.WordWrap
                font.pixelSize: 14
                color: palette.text
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
            }
        }
    }

    // About Dialog
    Dialog {
        id: aboutDialog
        title: qsTr("About")
        modal: true
        standardButtons: Dialog.Ok
        width: 400
        height: 220
        x: (window.width - width) / 2
        y: (window.height - height) / 2

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 15
            width: parent.width - 40

            Text {
                text: qsTr("Plasma Layout Manager")
                font.pixelSize: 18
                font.bold: true
                color: palette.text
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: qsTr("Version 1.0")
                font.pixelSize: 14
                color: palette.text
                Layout.alignment: Qt.AlignHCenter
            }

            Text {
                text: qsTr("A simple tool to manage KDE Plasma desktop layouts")
                wrapMode: Text.WordWrap
                color: palette.text
                Layout.alignment: Qt.AlignHCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
            }
        }
    }
}
