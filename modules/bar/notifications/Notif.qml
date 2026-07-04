import Quickshell
import QtQuick
import Quickshell.Services.Notifications
import Quickshell.Wayland
import QtQuick.Layouts
import QtQuick.Effects

Item{
    id : notifMainAnchor
    height : parent.height
    width : parent.width
    anchors.fill : parent
    Rectangle{
        id : notifAnchorRect
        anchors.fill : parent
        height : parent.height ; width : parent.width
        color : "transparent"
        Scope{
            id : serverRoot
            NotificationServer{
                id : notifServer
                bodySupported : true
                imageSupported : true
                actionsSupported : true
                onNotification : n => {
                    n.tracked = true
                }
            }
        }
        MouseArea {
            anchors.fill: parent
        }
    }
    PanelWindow {
        id : rootNotifPanel
        anchors {
            top : true
            right: true
        }
        margins{
            top : 12
            right : 12
        }

        exclusionMode : ExclusionMode.ignore
        implicitHeight : Math.max(1, mainCol.implicitHeight)
        implicitWidth : 320
        color : 'black'
        visible : notifServer.trackedNotifications.values.length > 0 
        Column{
            id : mainCol
            width : parent.width
            spacing : 12
            Repeater{
                model : notifServer.trackedNotifications.values
                delegate : Rectangle{
                    id : notifIndiv
                    implicitWidth : rootNotifPanel.implicitWidth
                    height : imgNtext.implicitHeight + 24
                    // property int revIndex: notifServer.trackedNotifications.values.length - 1 - index
                    // property var revArr: notifServer.trackedNotifications.values[revIndex]
                    color : '#e6000000'
                    Image {
                        width: parent.width; height: parent.height; anchors.fill: parent
                        fillMode: Image.PreserveAspectCrop; smooth: true; mipmap: true; antialiasing: true;
                        source: "/mnt/data/Utility OG/Pictures/download (70) (Edited) (3).jpg"; 
                        opacity: 0.433; layer.enabled: true
                        layer.effect: MultiEffect {
                            blurEnabled: true; blurMax: 16; blur: 0.6
                            shadowEnabled: false; shadowColor: "#000000"
                            shadowBlur: 0; shadowVerticalOffset: 0
                            brightness: 0; contrast: 0.233; saturation: 0.333
                            colorization: 0.2; colorizationColor: "#1e1e2e"
                        }
                    }
                    border.width : if(modelData.urgency === NotificationUrgency.Critical){
                                        2
                                    }else{
                                        1
                                    }
                                    border.color : if(modelData.urgency === NotificationUrgency.Critical){
                                        '#ff0048'
                                    }else{
                                        "#FFFFFF"
                                    }
                    
                    RowLayout{
                        id : imgNtext
                        anchors.fill : parent
                        spacing : 12
                        anchors.margins : 12

                        Image{
                            Layout.preferredWidth : 48
                            Layout.preferredHeight : 48
                            Layout.alignment : Qt.AlignTop
                            source : modelData.image || modelData.icon || ""
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                            antialiasing: true
                            visible: source.toString() !== ""
                        }

                        ColumnLayout{
                            id : textSpace
                            Layout.fillWidth : true
                            Layout.alignment : Qt.AlignTop
                            spacing : 4
                            Text{
                                color : "#FFFFFF"
                                font.bold : true
                                font.pixelSize : 18
                                wrapMode: Text.WordWrap
                                text : modelData.summary
                                Layout.fillWidth : true
                                font.family: "Orbitron"
                            }
                            Text{
                                color : "#FFFFFF"
                                wrapMode: Text.WordWrap
                                font.pixelSize : 14
                                text : modelData.body
                                font.bold : false
                                Layout.fillWidth : true
                                font.family: "Share Tech Mono"
                            }
                        }
                    }
                    MouseArea{
                        anchors.fill : parent
                        cursorShape : Qt.PointingHandCursor
                        onClicked : modelData.dismiss()
                    }

                    Timer{
                        interval : 3000
                        running : true
                        onTriggered  : modelData.dismiss()
                    }
                }
            }
        }
    }
}