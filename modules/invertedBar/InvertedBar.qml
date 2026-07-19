import Quickshell
import QtQuick
import Quickshell.Io
import QtQuick.Effects
import "wallpaperSwitcher"

PanelWindow{
    id: statusBar

    anchors{
        bottom : true
        left : true
        right : true
    }

    implicitHeight: 2
    exclusionMode : ExclusionMode.Ignore
    color : "transparent"
    
    Rectangle{
        id : powerMenuAnchor
        height : parent.height
        width : 100
        anchors.centerIn : parent
        anchors.bottom : parent.bottom
        color : "transparent"
        PaperSwapper{}
    }
}