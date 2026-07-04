import QtQuick
import Quickshell
import Quickshell.Hyprland

ArrowShape{
    arrowLeft : -1
    arrowRight : -1
    width : if (Hyprland.workspaces.values.length <= 3){
        130
    }else{
        (Hyprland.workspaces.values.length - 1)* 24 + 76
    }

    Behavior on width{
        NumberAnimation{
            duration : 200
            easing.type : Easing.OutExpo
        }
    }
    Row {
        anchors.centerIn : parent
        anchors.horizontalCenter : parent.horizontalCenter
        spacing: 12 
        height : parent.height
        
        Repeater {
            model: Hyprland.workspaces.values
            
            delegate: Rectangle {
                
                width: modelData.active? 32 : 12
                height: parent.height
                color : "transparent"
                anchors.verticalCenter: parent.verticalCenter
                Behavior on color {
                    ColorAnimation { duration: 250; easing.type: Easing.OutQuad }
                }

                Behavior on width {
                    NumberAnimation { duration: 150; easing.type : Easing.OutBack}
                }

                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true 
                    cursorShape: Qt.PointingHandCursor 
                    
                    onClicked: {
                        Hyprland.dispatch("hl.dsp.focus({ workspace = \"" + modelData.name + "\" })")
                    }
                }

                Rectangle{
                    width : parent.width
                    height : 12
                    anchors.centerIn : parent.centerIn
                    anchors.verticalCenter : parent.verticalCenter
                }
            }
        }
    }
}