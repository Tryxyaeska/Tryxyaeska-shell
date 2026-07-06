import Quickshell
import QtQuick
import Quickshell.Bluetooth
import Quickshell.Widgets
import Quickshell.Io
import "../../.."

Item {
    height: 30
    width: 50
    id: bluetoothMod

    Process {
        id: osCommand
        property string cmd: ""
        command: ["bash", "-c", cmd]
    }

    ArrowShape {
        anchors.fill : parent
        id: mainButton
        arrowLeft : 1
        arrowRight : -1
        width: 50
        height: 30

        Image {
            anchors.centerIn: parent
            width: 20
            height: 20
            fillMode: Image.PreserveAspectFit
            smooth : true; mipmap : true; antialiasing: true;
            source: Bluetooth.defaultAdapter.enabled ? "svgs/bluetooth/bluetooth.svg" : "svgs/bluetooth/bluetoothOff.svg"
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: myPopup.toggle() 
        }
    }

    HoverHandler {
        id: barHover
        onHoveredChanged: {
            if (hovered) {
                myPopup.open()
            }
        }
    }

    Timer {
        interval: 150
        running: myPopup.isOpen && !barHover.hovered && !myPopup.isHovered
        onTriggered: myPopup.close()
    }

    AnimatedPopup {
        id: myPopup
        anchorItem: mainButton
        parentWindow: statusBar
        popupWidth: 250
        popupHeight: 220
        menuGap : -2
        anmtSrc : Theme.btpopupbackground
        blurEnabled : Theme.btblurEnabled
        blur : Theme.btblur
        blurMax : Theme.btblurmax
        contrast : Theme.btcontrast
        saturation : Theme.btsaturation
        imgOpac : Theme.btimageopacity
        brightness : Theme.btbrightness
        colorization : Theme.btcolorization
        colorizationColor : Theme.btcolorizationCol

        Flickable {
            anchors.fill: parent
            anchors.margins: 0
            contentHeight: menuLayout.height
            clip: true

            Column {
                id: menuLayout
                spacing: 4
                anchors.horizontalCenter : parent.horizontalCenter
                
                Row {
                    id: row1
                    spacing: 30
                
                    Rectangle {
                        width: 50; height: 50; color: "transparent"; radius: 5;
                        Image { anchors.centerIn: parent; width: 28; height: 28; fillMode: Image.PreserveAspectFit; smooth : true; mipmap : true; antialiasing: true;
                            source: "svgs/bluetooth/bluetooth.svg"
                            opacity : Bluetooth.defaultAdapter.enabled ? btn1.containsMouse ? 1 : 0.7 : 0
                            Behavior on opacity{ NumberAnimation { duration : 150; easing.type : Easing.OutQuad}}}
                        Image { anchors.centerIn: parent; width: 28; height: 28; fillMode: Image.PreserveAspectFit; smooth : true; mipmap : true; antialiasing: true;
                            source: "svgs/bluetooth/bluetoothOff.svg"
                            opacity : Bluetooth.defaultAdapter.enabled ? 0 : btn1.containsMouse ? 1 : 0.7
                            Behavior on opacity{ NumberAnimation { duration : 150; easing.type : Easing.OutQuad}}}
                        MouseArea { id: btn1; anchors.fill: parent; cursorShape : Qt.PointingHandCursor; hoverEnabled: true; onClicked: if(Bluetooth.defaultAdapter) Bluetooth.defaultAdapter.enabled = !Bluetooth.defaultAdapter.enabled }
                    }

                    Rectangle {
                        width: 50; height: 50; color: "transparent"; radius: 5
                        Image { anchors.centerIn: parent; width: 28; height: 28; fillMode: Image.PreserveAspectFit; smooth : true; mipmap : true; antialiasing: true;
                            source: "svgs/bluetooth/black-hole.svg"
                            opacity : Bluetooth.defaultAdapter.discoverable ? 0 : btn2.containsMouse ? 1 : 0.7
                            Behavior on opacity{ NumberAnimation { duration : 150; easing.type : Easing.OutQuad}}}
                        Image { anchors.centerIn: parent; width: 28; height: 28; fillMode: Image.PreserveAspectFit; smooth : true; mipmap : true; antialiasing: true;
                            source: "svgs/bluetooth/incognito.svg"
                            opacity : Bluetooth.defaultAdapter.discoverable ? btn2.containsMouse ? 1 : 0.7 : 0
                            Behavior on opacity{ NumberAnimation { duration : 150; easing.type : Easing.OutQuad}}}
                        MouseArea { id: btn2; anchors.fill: parent; cursorShape : Qt.PointingHandCursor; hoverEnabled: true; onClicked: if(Bluetooth.defaultAdapter) Bluetooth.defaultAdapter.discoverable = !Bluetooth.defaultAdapter.discoverable }
                    }

                    Rectangle {
                        width: 50; height: 50; color: "transparent"; radius: 5
                        Image { anchors.centerIn: parent; width: 24; height: 24; opacity : btn3.containsMouse ? 1 : 0.7; smooth : true; mipmap : true; antialiasing: true; fillMode: Image.PreserveAspectFit; source: "svgs/bluetooth/send.svg" 
                        Behavior on opacity{ NumberAnimation { duration : 150; easing.type : Easing.OutQuad}}}
                        MouseArea { 
                            id: btn3; anchors.fill: parent; hoverEnabled: true; cursorShape : Qt.PointingHandCursor; 
                            onClicked: { osCommand.cmd = "blueman-sendto"; osCommand.running = true; myPopup.toggle() } 
                        }
                    }
                }

                Row {
                    id: row2
                    width: parent.width
                    spacing: 30
                
                    Rectangle {
                        width: 50; height: 50; color: "transparent"; radius: 5; anchors.leftMargin: 20
                        Image { anchors.centerIn: parent; width: 28; height: 28; opacity : btn5.containsMouse ? 1 : 0.7; smooth : true; mipmap : true; antialiasing: true; fillMode: Image.PreserveAspectFit; source: "svgs/bluetooth/galaxy-spiral-shape.svg" 
                        Behavior on opacity{ NumberAnimation { duration : 150; easing.type : Easing.OutQuad}}}
                        MouseArea { id: btn5; anchors.fill: parent; cursorShape : Qt.PointingHandCursor; hoverEnabled: true; onClicked: { osCommand.cmd = "blueman-manager"; osCommand.running = true; myPopup.toggle() } }
                    }

                    Rectangle {
                        width: 50; height: 50; color: "transparent"; radius: 5
                        Image { anchors.centerIn: parent; width: 28; height: 28; opacity : btn6.containsMouse ? 1 : 0.7; smooth : true; mipmap : true; antialiasing: true; fillMode: Image.PreserveAspectFit; source: "svgs/bluetooth/cpu.svg" 
                        Behavior on opacity{ NumberAnimation { duration : 150; easing.type : Easing.OutQuad}}}
                        MouseArea { id: btn6; anchors.fill: parent; cursorShape : Qt.PointingHandCursor; hoverEnabled: true; onClicked: { osCommand.cmd = "blueman-adapters"; osCommand.running = true; myPopup.toggle() } }
                    }

                    Rectangle {
                        width: 50; height: 50; color: "transparent"; radius: 5
                        Image { anchors.centerIn: parent; width: 28; height: 28; opacity : btn7.containsMouse ? 1 : 0.7; smooth : true; mipmap : true; antialiasing: true; fillMode: Image.PreserveAspectFit; source: "svgs/bluetooth/background.svg" 
                        Behavior on opacity{ NumberAnimation { duration : 150; easing.type : Easing.OutQuad}}}
                        MouseArea { id: btn7; anchors.fill: parent; cursorShape : Qt.PointingHandCursor; hoverEnabled: true; onClicked: { osCommand.cmd = "blueman-services"; osCommand.running = true; myPopup.toggle() } }
                    }
                }

                Text { text: "Reconnect to..."; color: "#a6adc8"; font.pixelSize: 14; font.bold: true; font.family: Theme.btFont; padding: 5 }
                Repeater {
                    model: ScriptModel {
                        values: Bluetooth.devices ? [...Bluetooth.devices.values].filter(d => d.paired) : []
                    }
                    delegate: Rectangle {
                        width: parent.width; height: 40; color: "transparent"; radius: 5
                        Row {
                            anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.left; anchors.leftMargin: 10; spacing: 10
                            IconImage { source: Quickshell.iconPath(modelData.icon); width: 20; height: 20 }
                            Text { text: modelData.name !== "" ? modelData.name : modelData.deviceName; color: modelData.connected ? "#a6e3a1" : "white" }
                        }
                        MouseArea { id: pBtn; anchors.fill: parent; cursorShape : Qt.PointingHandCursor; hoverEnabled: true; onClicked: modelData.connected ? modelData.disconnect() : modelData.connect() }
                    }
                }

                Rectangle {
                    width: parent.width; height: 35; color: "transparent"; radius: 5;
                    Text { anchors.verticalCenter: parent; font.pixelSize: 14; font.bold: true; font.family: Theme.btFont; padding: 5;color: Bluetooth.defaultAdapter?.discovering ? "#89b4fa" : btn4.containsMouse ? "white" : "#a6adc8"; text: Bluetooth.defaultAdapter?.discovering ? "Scanning..." : "Available Connections"; Behavior on color{ColorAnimation { duration: 150; easing.type: Easing.OutQuad}}}
                    MouseArea { id: btn4; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: if(Bluetooth.defaultAdapter) Bluetooth.defaultAdapter.discovering = !Bluetooth.defaultAdapter.discovering }
                }

                Repeater {
                    model: ScriptModel {
                        values: Bluetooth.devices ? [...Bluetooth.devices.values].filter(d => {
                            if (d.paired) return false; 
                            let displayName = d.name !== "" ? d.name : d.deviceName;
                            let isMacAddress = /^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$/.test(displayName);
                            return !isMacAddress; 
                        }) : []
                    }
                    delegate: Rectangle {
                        width: parent.width; height: 40; color: uBtn.containsMouse ? "#313244" : "transparent"; radius: 5
                        Row {
                            anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.left; anchors.leftMargin: 10; spacing: 10
                            IconImage { source: Quickshell.iconPath(modelData.icon); width: 20; height: 20 }
                            Text { text: modelData.name !== "" ? modelData.name : modelData.deviceName; color: "white" }
                        }
                        MouseArea { id: uBtn; anchors.fill: parent; hoverEnabled: true; onClicked: modelData.connect() }
                    }
                }
            }
        }
    }
}