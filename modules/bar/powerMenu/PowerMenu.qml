import Quickshell
import QtQuick
import Quickshell.Io
import QtQuick.Effects

Item{
    id : powerMenuAnchorMain
    height : parent.height
    width : parent.width
    anchors.fill : parent
    property bool visibility

    Process{
        id: osCommand
        property string cmd: ""
        command: ["bash", "-c", cmd]
    }

    Rectangle{
        id : powerMenuAnchorRect
        anchors.fill : parent
        height : parent.height ; width : parent.width
        color : "transparent"

        MouseArea {
            anchors.fill: parent
            hoverEnabled : true
        }

        HoverHandler{
            onHoveredChanged: {
                if(hovered){
                    visibility = true
                }else{
                    closeTimer.restart()
                }
            }
        }
    }
    
    PanelWindow{
        id: powerCenterMain
        anchors {
            left : true
            top : true
        }
        margins {
            top : 42
            left : 12
        }

        implicitWidth : visibility ? 206 : 0
        implicitHeight : visibility ? 98 : 60
        Behavior on implicitWidth {NumberAnimation {duration: 50; easing.type: Easing.InOutBack}}
        Behavior on implicitHeight {NumberAnimation {duration: 50; easing.type: Easing.InOutBack}}
        color : "black"
        exclusionMode : ExclusionMode.Ignore
        
        Timer {
            id: closeTimer
            interval: 600
            onTriggered: visibility = false
        }

        HoverHandler {
            onHoveredChanged: {
                if (hovered) {
                    closeTimer.stop()
                } else {
                    closeTimer.restart()
                }
            }
        }

        Item{
            anchors.fill : parent
            clip : true
            Rectangle{
                border.width : 1
                border.color : visibility ? "#FFFFFF" : "transparent"
                color : "transparent"
                height : parent.height
                width : parent.width
                Image {
                        width: parent.width; height: parent.height; anchors.fill: parent
                        fillMode: Image.PreserveAspectCrop; smooth: true; mipmap: true; antialiasing: true;
                        source: "/mnt/data/Utility OG/Pictures/destiny (4).jpg"; 
                        opacity: 0.433; layer.enabled: true
                        layer.effect: MultiEffect {
                            blurEnabled: true; blurMax: 8; blur: 0.6
                            shadowEnabled: false; shadowColor: "#000000"
                            shadowBlur: 0; shadowVerticalOffset: 0
                            brightness: 0; contrast: 0.233; saturation: 0.333
                            colorization: 0.2; colorizationColor: "#1e1e2e"
                        }
                    }
            }
        }

        Column{
            anchors.fill : parent
            spacing : 20
            anchors.margins :12

            Row{
                spacing : 24
                Rectangle{
                    height : 28
                    width : 28
                    color : "transparent"
                    Image{
                        anchors.fill : parent
                        source : "svgs/powerOff.svg"
                        mipmap : true
                        antialiasing : true
                        smooth : true
                        opacity : bt1.containsMouse ? 1 : 0.8
                        Behavior on opacity{
                            NumberAnimation{
                                duration : 130
                                easing.type : Easing.OutQuad
                            }
                        }
                    }
                    MouseArea{
                        id : bt1
                        anchors.fill : parent
                        hoverEnabled : true
                        cursorShape : Qt.PointingHandCursor
                        onClicked: {osCommand.cmd = "systemctl poweroff"; osCommand.running = true; visibility = false}
                    }
                }
                Rectangle{
                    height : 28
                    width : 28
                    color : "transparent"
                    Image{
                        anchors.fill : parent
                        source : "svgs/restart.svg"
                        mipmap : true
                        antialiasing : true
                        smooth : true
                        opacity : bt2.containsMouse ? 1 : 0.8
                        Behavior on opacity{
                            NumberAnimation{
                                duration : 130
                                easing.type : Easing.OutQuad
                            }
                        }
                    }
                    MouseArea{
                        id : bt2
                        anchors.fill : parent
                        hoverEnabled : true
                        cursorShape : Qt.PointingHandCursor
                        onClicked: {osCommand.cmd = "systemctl reboot"; osCommand.running = true; visibility = false}
                    }
                }
                Rectangle{
                    height : 28
                    width : 28
                    color : "transparent"
                    Image{
                        anchors.fill : parent
                        source : "svgs/suspend.svg"
                        mipmap : true
                        antialiasing : true
                        smooth : true
                        opacity : bt3.containsMouse ? 1 : 0.8
                        Behavior on opacity{
                            NumberAnimation{
                                duration : 130
                                easing.type : Easing.OutQuad
                            }
                        }
                    }
                    MouseArea{
                        id : bt3
                        anchors.fill : parent
                        hoverEnabled : true
                        cursorShape : Qt.PointingHandCursor
                        onClicked: {osCommand.cmd = "systemctl suspend"; osCommand.running = true; visibility = false}
                    }
                }
                Rectangle{
                    height : 28
                    width : 28
                    color : "transparent"
                    Image{
                        anchors.fill : parent
                        source : "svgs/stasis.svg"
                        mipmap : true
                        antialiasing : true
                        smooth : true
                        opacity : bt4.containsMouse ? 1 : 0.8
                        Behavior on opacity{
                            NumberAnimation{
                                duration : 130
                                easing.type : Easing.OutQuad
                            }
                        }
                    }
                    MouseArea{
                        id : bt4
                        anchors.fill : parent
                        hoverEnabled : true
                        cursorShape : Qt.PointingHandCursor
                        onClicked: {osCommand.cmd = "systemctl hibernate"; osCommand.running = true; visibility = false}
                    }
                }
            }

            Row{
                spacing : 24
                Rectangle{
                    height : 28
                    width : 28
                    color : "transparent"
                    Image{
                        anchors.fill : parent
                        source : "svgs/crash.svg"
                        mipmap : true
                        antialiasing : true
                        smooth : true
                        opacity : bt5.containsMouse ? 1 : 0.8
                        Behavior on opacity{
                            NumberAnimation{
                                duration : 130
                                easing.type : Easing.OutQuad
                            }
                        }
                    }
                    MouseArea{
                        id : bt5
                        anchors.fill : parent
                        hoverEnabled : true
                        cursorShape : Qt.PointingHandCursor
                        onClicked: {osCommand.cmd = "hyprctl dispatch exit"; osCommand.running = true; visibility = false}
                    }
                }
                Rectangle{
                    height : 28
                    width : 28
                    color : "transparent"
                    Image{
                        anchors.fill : parent
                        source : "svgs/lock.svg"
                        mipmap : true
                        antialiasing : true
                        smooth : true
                        opacity : bt6.containsMouse ? 1 : 0.8
                        Behavior on opacity{
                            NumberAnimation{
                                duration : 130
                                easing.type : Easing.OutQuad
                            }
                        }
                    }
                    MouseArea{
                        id : bt6
                        anchors.fill : parent
                        hoverEnabled : true
                        cursorShape : Qt.PointingHandCursor
                        onClicked: {osCommand.cmd = "loginctl lock-session"; osCommand.running = true; visibility = false}
                    }
                }
                Rectangle{
                    height : 28
                    width : 28
                    color : "transparent"
                    Image{
                        anchors.fill : parent
                        source : "svgs/hyprReload.svg"
                        mipmap : true
                        antialiasing : true
                        smooth : true
                        opacity : bt7.containsMouse ? 1 : 0.8
                        Behavior on opacity{
                            NumberAnimation{
                                duration : 130
                                easing.type : Easing.OutQuad
                            }
                        }
                    }
                    MouseArea{
                        id : bt7
                        anchors.fill : parent
                        hoverEnabled : true
                        cursorShape : Qt.PointingHandCursor
                        onClicked: {osCommand.cmd = "hyprctl reload"; osCommand.running = true; visibility = false}
                    }
                }
                Rectangle{
                    height : 28
                    width : 28
                    color : "transparent"
                    Image{
                        anchors.fill : parent
                        source : "svgs/killall.svg"
                        mipmap : true
                        antialiasing : true
                        smooth : true
                        opacity : bt8.containsMouse ? 1 : 0.8
                        Behavior on opacity{
                            NumberAnimation{
                                duration : 130
                                easing.type : Easing.OutQuad
                            }
                        }
                    }
                    MouseArea{
                        id : bt8
                        anchors.fill : parent
                        hoverEnabled : true
                        cursorShape : Qt.PointingHandCursor
                        onClicked: {osCommand.cmd = "hyprctl kill"; osCommand.running = true; visibility = false}
                    }
                }
            }
        }
    }
}