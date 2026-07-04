import Quickshell
import QtQuick
import Quickshell.Services.Notifications
import Quickshell.Wayland
import QtQuick.Layouts

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
                    border.width : if(modelData.urgency === NotificationUrgency.Critical){
                        2
                    }else{
                        1
                    }
                    border.color : if(modelData.urgency === NotificationUrgency.Critical){
                        '#f63c09'
                    }else{
                        "#FFFFFF"
                    }

                    Timer{
                        interval : 3000
                        running : true
                        onTriggered  : modelData.dismiss()
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
                            }
                            Text{
                                color : "#FFFFFF"
                                wrapMode: Text.WordWrap
                                font.pixelSize : 14
                                text : modelData.body
                                Layout.fillWidth : true
                            }
                        }
                    }
                    MouseArea{
                        anchors.fill : parent
                        cursorShape : Qt.PointingHandCursor
                        onClicked : modelData.dismiss()
                    }
                }
            }
        }
    }
}