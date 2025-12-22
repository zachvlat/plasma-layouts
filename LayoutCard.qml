import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Rectangle {
    id: root
    
    property string layoutName: ""
    property string layoutIcon: ""
    property string layoutDescription: ""
    property real cardRadius: 12
    signal applyClicked(string layoutName)
    
    color: palette.base
    radius: cardRadius
    border.color: palette.mid
    border.width: 1
    
    // Material elevation shadow
    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowBlur: 0.6
        shadowColor: "black"
        shadowOpacity: 0.15
        shadowVerticalOffset: 2
        shadowHorizontalOffset: 0
    }
    
    Behavior on color {
        ColorAnimation { duration: 200 }
    }
    
    Behavior on border.color {
        ColorAnimation { duration: 200 }
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        
        onEntered: {
            parent.color = palette.alternateBase
            parent.border.color = palette.highlight
        }
        
        onExited: {
            parent.color = palette.base
            parent.border.color = palette.mid
        }
        
        onClicked: root.applyClicked(root.layoutName)
    }
    
    property real cardHeight: root.height || 320

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: cardHeight < 250 ? 16 : 30
        spacing: cardHeight < 250 ? 12 : 20
        
        // Icon
        Text {
            text: layoutIcon
            font.pixelSize: cardHeight < 250 ? 32 : 48
            Layout.alignment: Qt.AlignHCenter
        }
        
        // Title
        Text {
            text: layoutName
            font.pixelSize: cardHeight < 250 ? 16 : 22
            font.bold: true
            font.family: "Segoe UI, sans-serif"
            color: palette.text
            Layout.alignment: Qt.AlignHCenter
        }
        
        // Description
        Text {
            text: layoutDescription
            font.pixelSize: cardHeight < 250 ? 11 : 14
            color: palette.text
            opacity: 0.8
            wrapMode: Text.WordWrap
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            horizontalAlignment: Text.AlignHCenter
            visible: cardHeight > 200
        }
        
        Item { Layout.fillHeight: true }
        
        // Apply Button
        Button {
            text: "Apply"
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: cardHeight < 250 ? 100 : 120
            Layout.preferredHeight: cardHeight < 250 ? 32 : 40
            
            background: Rectangle {
                color: parent.down ? palette.highlight : 
                       parent.hovered ? palette.highlight.darker(110) : palette.highlight
                radius: 8
                
                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }
            
            contentItem: Text {
                text: parent.text
                color: "white"
                font.pixelSize: cardHeight < 250 ? 12 : 14
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            
            onClicked: root.applyClicked(root.layoutName)
        }
    }
}