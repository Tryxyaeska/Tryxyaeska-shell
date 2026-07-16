import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../../.."

ArrowShape{
    id : workspaceArrow
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

    MouseArea{
        id : workspaceArrowCursor
        anchors.fill : parent
        hoverEnabled : true
    }

    Row {
        anchors.centerIn : parent
        anchors.horizontalCenter : parent.horizontalCenter
        spacing: 12 
        height : parent.height
        
        Repeater {
            model: Hyprland.workspaces.values
            
            delegate: Rectangle {
                
                width: modelData.active? 33 : 13
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
                    id: mainCursor
                    anchors.fill: parent
                    // hoverEnabled: true 
                    cursorShape: Qt.PointingHandCursor 
                    
                    onClicked: {
                        Hyprland.dispatch("hl.dsp.focus({ workspace = \"" + modelData.name + "\" })")
                    }
                }

                Rectangle{
                    width : parent.width
                    height : 13
                    anchors.centerIn : parent.centerIn
                    anchors.verticalCenter : parent.verticalCenter

                    Text{
                        opacity : workspaceArrowCursor.containsMouse ? 1 : 0
                        anchors.centerIn : parent
                        anchors.topMargin: -3
                        color : "black"
                        font.pixelSize : 11
                        text : modelData.name
                        font.bold : true
                        font.family : Theme.workspaceFontFamily
                        Behavior on opacity{
                            NumberAnimation{
                                duration : 130
                                easing.type : Easing.OutQuad
                            }
                        }
                    }
                }
            }
        }
    }
}