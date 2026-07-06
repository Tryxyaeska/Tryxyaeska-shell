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
    property bool centerVisibility
    onCenterVisibilityChanged: {
        if (centerVisibility === true) {
            let daemonNotifs = notifServer.trackedNotifications.values
            for (let i = daemonNotifs.length - 1; i >= 0; i--) {
                daemonNotifs[i].dismiss()
            }
        }
    }
    Rectangle{
        id : notifAnchorRect
        anchors.fill : parent
        height : parent.height ; width : parent.width
        color : "transparent"
        Scope{
            id : serverRoot

            ListModel{
                id : notifCenterDb
            }

            NotificationServer{
                id : notifServer
                bodySupported : true
                imageSupported : true
                actionsSupported : true
                onNotification : n => {
                    n.tracked = true
                    notifCenterDb.insert(0, {
                        summary : n.summary,
                        body : n.body,
                        urgency : n.urgency,
                        senderApp : n.appName,
                        id : n.id,
                        icon: n.image || n.icon || "",
                        time : Qt.formatDateTime(new Date(), "HH:mm:ss")
                    })
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled : true
        }

        HoverHandler{
            onHoveredChanged: {
                if (hovered) {
                    centerVisibility = true
                }
            }
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
        visible : notifServer.trackedNotifications.values.length > 0 && !centerVisibility
        Column{
            id : mainCol
            width : parent.width
            spacing : 12
            clip : true
            Repeater{
                model : notifServer.trackedNotifications.values
                delegate : Rectangle{
                    id : notifIndiv
                    implicitWidth : rootNotifPanel.implicitWidth
                    height : imgNtext.implicitHeight + 24
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
                        hoverScanner.containsMouse ? '#ff0048' : '#ecff0048'
                    }else{
                        hoverScanner.containsMouse ?  "#FFFFFF" : "#a6adc8"
                    }
                    Behavior on border.color { 
                        ColorAnimation { duration: 250; easing.type: Easing.OutQuart } 
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
                                font.bold : true
                                Layout.fillWidth : true
                                font.family: "Share Tech Mono"
                            }
                        }
                    }
                    MouseArea{
                        id : hoverScanner
                        anchors.fill : parent
                        cursorShape : Qt.PointingHandCursor
                        onClicked : modelData.dismiss()
                        hoverEnabled : true
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

    PanelWindow{
        id: notifCenterMain
        anchors {
            right : true
            top : true
        }
        margins {
            top : 7
            right : 7
        }

        implicitWidth : centerVisibility ? 350 : 0
        implicitHeight : centerVisibility ? Math.min(806, centerCol.implicitHeight + 15) : 0
        Behavior on implicitWidth {NumberAnimation {duration: 50; easing.type: Easing.InOutBack}}
        Behavior on implicitHeight {NumberAnimation {duration: 50; easing.type: Easing.InOutBack}}
        color : "black"
        exclusionMode : ExclusionMode.ignore
        
        Timer {
            id: closeTimer
            interval: 600
            onTriggered: centerVisibility = false
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
        Rectangle{
            anchors.fill : parent
            border.width : 1
            border.color : centerVisibility ? "#FFFFFF" : "transparent"
            color : "transparent"
        }
        Image {
            width: parent.width
            height: parent.height 
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop; smooth: true; mipmap: true; antialiasing: true;
            source: "/mnt/data/Utility OG/Pictures/bg-1.jpg"; 
            opacity: 0.6; layer.enabled: true
            layer.effect: MultiEffect {
                blurEnabled: true; blurMax: 16; blur: 0.6
                shadowEnabled: false; shadowColor: "#000000"
                shadowBlur: 0; shadowVerticalOffset: 0
                brightness: 0; contrast: 0.0; saturation: 0.0
                colorization: 0.0; colorizationColor: "#1e1e2e"
            }
        }
        Item{
            anchors.fill : parent
            clip : true

            Column{
                id : centerCol
                width : parent.width
                spacing : 12
                anchors.top : parent.top
                anchors.margins : 4

                RowLayout{
                    id : notifCenterMainRow
                    anchors.left : parent.left
                    anchors.right : parent.right
                    anchors.margins : 12
                    Text{
                        font.pixelSize : 24
                        font.family : "Orbitron"
                        font.bold : true
                        text : "Notifications"
                        color : centerVisibility ? "#FFFFFF" : "transparent"
                    }

                    Item {
                        Layout.fillWidth: true
                    }

                    Rectangle {
                        id : clearAllRect
                        Layout.preferredWidth : clearText.implicitWidth
                        Layout.preferredHeight : clearText.implicitHeight
                        color : "transparent"
                        Text {
                            id : clearText
                            anchors.centerIn : parent
                            font.pixelSize : 14
                            font.family : "Share Tech Mono"
                            font.bold : true
                            text : "Clear All"
                            color : centerVisibility ? clearAllBtn.containsMouse ? "white" : '#cacaca' : "transparent"
                            Behavior on color{ColorAnimation { duration: 150; easing.type: Easing.OutQuad}}
                        }

                        MouseArea{
                            id : clearAllBtn
                            anchors.fill : parent
                            cursorShape : Qt.PointingHandCursor
                            hoverEnabled : true
                            onClicked : notifCenterDb.clear()
                            visible : centerVisibility 
                        }
                    }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter 
                    font.pixelSize: 18
                    font.bold : true
                    color: centerVisibility ? '#c9c9c9' : "transparent" 
                    text: "No Notifications"
                    visible: notifCenterDb.count === 0
                    font.family : "Share Tech Mono"
                    height : 36
                }
                
                ListView{
                    id : notifCenterList
                    anchors.left : parent.left
                    anchors.right : parent.right
                    anchors.margins : 12
                    implicitHeight : contentHeight
                    interactive : false
                    spacing : 12
                    model: notifCenterDb

                    delegate : Rectangle{
                        width : notifCenterList.width
                        height : imgNtext2.implicitHeight + 24
                        color : '#e6000000'
                        Image {
                            width: parent.width
                            height: parent.height 
                            anchors.fill: parent
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
                        border.width : if(urgency === NotificationUrgency.Critical){
                                            2
                                        }else{
                                            1
                                        }
                        border.color : if(urgency === NotificationUrgency.Critical){
                            hoverScanner2.containsMouse ? '#ff0048' : '#ecff0048'
                        }else{
                            centerVisibility ? hoverScanner2.containsMouse ?  "#FFFFFF" : "#a6adc8" : "transparent"
                        }
                        Behavior on border.color { 
                            ColorAnimation { duration: 250; easing.type: Easing.OutQuart } 
                        }

                        RowLayout{
                            id : imgNtext2
                            anchors.fill : parent
                            spacing : 12
                            anchors.margins : 12

                            Image{
                                Layout.preferredWidth : 48
                                Layout.preferredHeight : 48
                                Layout.alignment : Qt.AlignTop
                                source : icon
                                fillMode: Image.PreserveAspectFit
                                smooth: true
                                antialiasing: true
                                visible: source.toString() !== ""
                            }

                            ColumnLayout {
                                id : textSpace
                                Layout.fillWidth : true
                                Layout.alignment : Qt.AlignTop
                                spacing : 4

                                RowLayout{
                                    Layout.fillWidth : true
                                    Layout.alignment : Qt.AlignTop
                                    spacing: 12
                                    
                                    Text{
                                        color : "#FFFFFF"
                                        font.bold : true
                                        font.pixelSize : 18
                                        wrapMode: Text.WordWrap
                                        text : summary
                                        Layout.fillWidth : true 
                                        Layout.alignment : Qt.AlignTop
                                        font.family: "Orbitron"
                                    }
                                    
                                    Text{
                                        color : '#ffffff'
                                        font.pixelSize : 12
                                        text : time
                                        font.bold : true
                                        Layout.alignment : Qt.AlignTop | Qt.AlignRight 
                                        font.family: "Share Tech Mono"
                                    }
                                }
                                Text{
                                    color : "#FFFFFF"
                                    wrapMode: Text.WordWrap
                                    font.pixelSize : 14
                                    text : body
                                    font.bold : true
                                    Layout.fillWidth : true
                                    font.family: "Share Tech Mono"
                                }
                            }
                        }

                        Timer{
                            id : centerAutoDismisser
                            interval : 3600000
                            running : true
                            onTriggered : notifCenterDb.remove(index)
                        }

                        MouseArea{
                            id : hoverScanner2
                            anchors.fill : parent
                            cursorShape : Qt.PointingHandCursor
                            hoverEnabled : true
                            onClicked : notifCenterDb.remove(index)
                        }
                    }
                }
            }
        }
    }
}