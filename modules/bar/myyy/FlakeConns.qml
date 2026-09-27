import Quickshell
import Quickshell.Wayland
import Quickshell.Networking
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import "../../.."

PanelWindow {
    id: connsFlakeWindow

    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    exclusionMode: ExclusionMode.Ignore
    visible: false
    color: "transparent"

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.AllButtons
        onClicked: connsFlakeWindow.visible = false
    }

    Process {
        id: osCommand
        property string cmd: ""
        command: ["bash", "-c", cmd]
    }

    property string currentWifiName: {
        let wifiAdapter = Networking.devices ? Networking.devices.values.find(d => d.type === DeviceType.Wifi) : null;
        if (!wifiAdapter || !wifiAdapter.networks) return "Disconnected";
        let activeNet = wifiAdapter.networks.values.find(n => n.connected === true);
        return activeNet ? activeNet.name : "Disconnected";
    }

    function getWifiStrength(networkName) {
        let wifiAdapter = Networking.devices ? Networking.devices.values.find(d => d.type === DeviceType.Wifi) : null;
        if (!wifiAdapter || !wifiAdapter.networks) return 0;
        let targetNet = wifiAdapter.networks.values.find(n => n.name === networkName);
        return targetNet ? targetNet.signalStrength : 0;
    }

    Item {
        id: flakeContainer
        width: 640
        height: 340
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 30

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.AllButtons
        }

        Column {
            anchors.fill: parent
            spacing: 0

            // Top connector line
            Rectangle {
                width: parent.width 
                anchors.horizontalCenter: parent.horizontalCenter
                height: 3
                radius: 1
                color: Theme.flakeAccentCol
            }

            FlakeShape {
                width: parent.width
                height: parent.height - 3
                slantOffset: 55
                cornerRadius: 22
                boxColor: Theme.flakeBg
                borderColor: Theme.flakeBorderCol
                borderWidth: 3
                borderBottom: true
                borderLeft: true
                borderRight: true

                Row {
                    anchors.fill: parent
                    anchors.margins: 18
                    anchors.topMargin: 14
                    spacing: 16

                    //LeftSide
                    Column {
                        width: 220
                        height: parent.height
                        spacing: 10

                        Rectangle {
                            width: parent.width
                            height: 52
                            radius: 10
                            color: Theme.flakeContainerCol
                            border.color: Networking.wifiEnabled ? Theme.flakeAccentCol : Theme.flakeBorderCol
                            border.width: 1

                            Row {
                                anchors.centerIn: parent
                                spacing: 10

                                // Wifi Main
                                Rectangle {
                                    width: 10
                                    height: 10
                                    radius: 5
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: Networking.wifiEnabled ? Theme.flakeActiveIndicator : Theme.flakeErrorCol
                                }

                                Column {
                                    anchors.verticalCenter: parent.verticalCenter
                                    spacing: 2

                                    Text {
                                        text: Networking.wifiEnabled ? "ONLINE INTERFACE" : "RADIO SILENT"
                                        font.pixelSize: 10
                                        font.bold: true
                                        font.letterSpacing: 1.2
                                        font.family: Theme.intFont
                                        color: Theme.flakeSubTextCol
                                    }

                                    Text {
                                        text: connsFlakeWindow.currentWifiName
                                        font.pixelSize: 13
                                        font.bold: true
                                        font.family: Theme.intFont
                                        color: Theme.flakePrimaryTextCol
                                        elide: Text.ElideRight
                                        width: 150
                                    }
                                }
                            }
                        }

                        // Activation Buttons
                        Row {
                            width: parent.width
                            spacing: 8

                            // Wi-Fi Button
                            Rectangle {
                                width: (parent.width - 8) / 2
                                height: 42
                                radius: 8
                                color: wifiTglMouse.containsMouse 
                                       ? Theme.flakeHoverCol 
                                       : (Networking.wifiEnabled ? Theme.flakeAccentCol : Theme.flakeContainerCol)
                                border.color: Networking.wifiEnabled ? Theme.flakeAccentCol : Theme.flakeBorderCol
                                border.width: 1

                                Behavior on color { ColorAnimation { duration: 150 } }

                                Row {
                                    anchors.centerIn: parent
                                    spacing: 6
                                    Image {
                                        anchors.verticalCenter: parent.verticalCenter
                                        width: 18; height: 18
                                        source: Networking.wifiEnabled ? "../components/svgs/network/wifi (4).svg" : "../components/svgs/network/wifiOff.svg"
                                    }
                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: Networking.wifiEnabled ? "Wi-Fi" : "Off"
                                        font.pixelSize: 11
                                        font.bold: true
                                        font.family: Theme.intFont
                                        color: (Networking.wifiEnabled && !wifiTglMouse.containsMouse) ? Theme.flakeOnAccentTextCol : Theme.flakePrimaryTextCol
                                    }
                                }

                                MouseArea {
                                    id: wifiTglMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        osCommand.cmd = "nmcli radio wifi | grep -q 'enabled' && nmcli radio wifi off || nmcli radio wifi on"
                                        osCommand.running = true
                                    }
                                }
                            }

                            //Networking Button
                            Rectangle {
                                id: netMasterBtn
                                width: (parent.width - 8) / 2
                                height: 42
                                radius: 8
                                property bool isNetOn: Networking.wifi ? Networking.wifiEnabled : true

                                color: netTglMouse.containsMouse 
                                       ? Theme.flakeHoverCol 
                                       : (netMasterBtn.isNetOn ? Theme.flakeAccentCol : Theme.flakeContainerCol)
                                border.color: netMasterBtn.isNetOn ? Theme.flakeAccentCol : Theme.flakeBorderCol
                                border.width: 1

                                Behavior on color { ColorAnimation { duration: 150 } }

                                Row {
                                    anchors.centerIn: parent
                                    spacing: 6
                                    Image {
                                        anchors.verticalCenter: parent.verticalCenter
                                        width: 18; height: 18
                                        source: netMasterBtn.isNetOn ? "../components/svgs/network/networkOn.svg" : "../components/svgs/network/networkOff.svg"
                                    }
                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        text: netMasterBtn.isNetOn ? "Net" : "Cut"
                                        font.pixelSize: 11
                                        font.bold: true
                                        font.family: Theme.intFont
                                        color: (netMasterBtn.isNetOn && !netTglMouse.containsMouse) ? Theme.flakeOnAccentTextCol : Theme.flakePrimaryTextCol
                                    }
                                }

                                MouseArea {
                                    id: netTglMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        netMasterBtn.isNetOn = !netMasterBtn.isNetOn
                                        osCommand.cmd = "nmcli networking | grep -q 'enabled' && nmcli networking off || nmcli networking on"
                                        osCommand.running = true
                                    }
                                }
                            }
                        }

                        // Utility Buttons
                        Row {
                            width: parent.width
                            height: 34
                            spacing: 8

                            Repeater {
                                model: [
                                    { icon: "edit.svg", cmd: "nm-connection-editor", tip: "Settings" },
                                    { icon: "info.svg", cmd: "nm-connection-editor", tip: "Diagnostics" },
                                    { icon: "hidden.svg", cmd: "nm-connection-editor -c -t 802-11-wireless", tip: "Hidden" },
                                    { icon: "create.svg", cmd: "nm-connection-editor -c -t 802-11-wireless", tip: "Hotspot" }
                                ]

                                delegate: Rectangle {
                                    width: (menuLayout.width - 24) / 4
                                    height: 34
                                    radius: 6
                                    color: toolMouse.containsMouse ? Theme.flakeHoverCol : Theme.flakeContainerCol
                                    border.color: toolMouse.containsMouse ? Theme.flakeAccentCol : Theme.flakeBorderCol
                                    border.width: 1

                                    Image {
                                        anchors.centerIn: parent
                                        width: 18; height: 18
                                        source: "../components/svgs/network/" + modelData.icon
                                    }

                                    MouseArea {
                                        id: toolMouse
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            osCommand.cmd = modelData.cmd
                                            osCommand.running = true
                                            connsFlakeWindow.visible = false
                                        }
                                    }
                                }
                            }
                        }

                        // WiredSpace
                        Rectangle {
                            width: parent.width
                            height: 85
                            radius: 8
                            color: Theme.flakeContainerLowCol
                            border.color: Theme.flakeBorderCol
                            border.width: 1

                            Column {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 4

                                Text {
                                    text: "WIRED ADAPTERS"
                                    font.pixelSize: 9
                                    font.bold: true
                                    font.letterSpacing: 1.1
                                    font.family: Theme.intFont
                                    color: Theme.flakeSubTextCol
                                }

                                Column {
                                    width: parent.width
                                    spacing: 4
                                    property var wiredDevices: Networking.devices 
                                        ? Networking.devices.values.filter(d => d.type === DeviceType.Wired) 
                                        : []

                                    Repeater {
                                        model: parent.wiredDevices
                                        delegate: Row {
                                            width: parent.width
                                            spacing: 8
                                            Image {
                                                source: "../components/svgs/network/ethernet.svg"
                                                width: 15; height: 15
                                                anchors.verticalCenter: parent.verticalCenter
                                            }
                                            Text {
                                                text: modelData.name
                                                font.pixelSize: 11
                                                font.bold: true
                                                font.family: Theme.intFont
                                                color: modelData.connected ? Theme.flakeActiveIndicator : Theme.flakeSubTextCol
                                                anchors.verticalCenter: parent.verticalCenter
                                            }
                                        }
                                    }

                                    Text {
                                        visible: parent.wiredDevices.length === 0
                                        text: "No active physical line"
                                        font.pixelSize: 11
                                        font.italic: true
                                        color: Theme.flakeSubTextCol
                                    }
                                }
                            }
                        }
                    }

                    // Vertical Divider
                    Rectangle {
                        height: parent.height - 10
                        width: 1
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.flakeBorderCol
                    }

                    //Avl Conns
                    Column {
                        width: parent.width - 220 - 1 - 32
                        height: parent.height
                        spacing: 8

                        // Scan/Rescan
                        RowLayout {
                            width: parent.width
                            height: 24

                            Text {
                                text: "AVAILABLE SPECTRUM"
                                font.pixelSize: 10
                                font.bold: true
                                font.letterSpacing: 1.2
                                font.family: Theme.intFont
                                color: Theme.flakeSubTextCol
                                Layout.fillWidth: true
                            }

                            // Scan Button
                            Rectangle {
                                width: 85
                                height: 22
                                radius: 11
                                color: scanMouse.containsMouse ? Theme.flakeHoverCol : Theme.flakeContainerCol
                                border.color: scanContainer.isScanning ? Theme.flakeAccentCol : Theme.flakeBorderCol
                                border.width: 1

                                id: scanContainer
                                property bool isScanning: false

                                Row {
                                    anchors.centerIn: parent
                                    spacing: 4
                                    Text {
                                        text: scanContainer.isScanning ? "⚡" : "⟳"
                                        font.pixelSize: 11
                                        color: Theme.flakePrimaryTextCol
                                    }
                                    Text {
                                        text: scanContainer.isScanning ? "SCANNING" : "RESCAN"
                                        font.pixelSize: 9
                                        font.bold: true
                                        color: Theme.flakePrimaryTextCol
                                    }
                                }

                                MouseArea {
                                    id: scanMouse
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        if (!scanContainer.isScanning) {
                                            scanContainer.isScanning = true
                                            osCommand.cmd = "nmcli device wifi rescan"
                                            osCommand.running = true
                                            scanTimer.start()
                                        }
                                    }
                                }

                                Timer { id: scanTimer; interval: 5000; onTriggered: scanContainer.isScanning = false }
                            }
                        }

                        // Avl Conns List
                        Flickable {
                            width: parent.width
                            height: parent.height - 34
                            contentHeight: availColumn.height
                            clip: true

                            QsMenuOpener {
                                id: netWorkMainTray
                                menu: {
                                    let item = SystemTray.items.values.find(x => x.title === "Network");
                                    return item ? item.menu : null;
                                }
                            }
                            QsMenuOpener {
                                id: avlConnsMain
                                menu: {
                                    if (!netWorkMainTray.children) return null;
                                    let item = netWorkMainTray.children.values.find(x => x.text === "Available networks");
                                    return item ? item : null;
                                }
                            }

                            Column {
                                id: availColumn
                                width: parent.width
                                spacing: 4

                                Repeater {
                                    model: avlConnsMain.children ? avlConnsMain.children.values : []

                                    delegate: Rectangle {
                                        id: netRow
                                        width: availColumn.width
                                        height: 38
                                        radius: 8

                                        property real signalRatio: connsFlakeWindow.getWifiStrength(modelData.text)
                                        property bool isActive: modelData.text === connsFlakeWindow.currentWifiName

                                        color: netItemMouse.containsMouse 
                                               ? Theme.flakeHoverCol 
                                               : (isActive ? Theme.flakeContainerCol : Theme.flakeBg)
                                        border.color: isActive ? Theme.flakeAccentCol : Theme.flakeBorderCol
                                        border.width: 1

                                        Behavior on color { ColorAnimation { duration: 120 } }

                                        Row {
                                            anchors.fill: parent
                                            anchors.leftMargin: 10
                                            anchors.rightMargin: 10
                                            spacing: 10

                                            //WifiIcon
                                            Image {
                                                width: 16; height: 16
                                                anchors.verticalCenter: parent.verticalCenter
                                                source: {
                                                    let s = netRow.signalRatio * 100;
                                                    if (s >= 75) return "../components/svgs/network/wifi (4).svg";
                                                    if (s >= 50) return "../components/svgs/network/wifi (3).svg";
                                                    if (s >= 25) return "../components/svgs/network/wifi (2).svg";
                                                    return "../components/svgs/network/wifi (1).svg";
                                                }
                                            }

                                            //SSID Name
                                            Text {
                                                text: modelData.text
                                                font.pixelSize: 12
                                                font.bold: netRow.isActive
                                                font.family: Theme.intFont
                                                color: netRow.isActive ? Theme.flakeAccentCol : Theme.flakePrimaryTextCol
                                                anchors.verticalCenter: parent.verticalCenter
                                                elide: Text.ElideRight
                                                width: 180
                                            }

                                            Item { Layout.fillWidth: true; width: 1; height: 1 }

                                            //StepSignalLvlIndicator
                                            Row {
                                                anchors.verticalCenter: parent.verticalCenter
                                                spacing: 2

                                                Repeater {
                                                    model: 4
                                                    delegate: Rectangle {
                                                        width: 3
                                                        height: 5 + (index * 3)
                                                        radius: 1
                                                        anchors.bottom: parent.bottom
                                                        color: (netRow.signalRatio * 4) > index 
                                                               ? (netRow.isActive ? Theme.flakeAccentCol : Theme.flakeBorderCol)
                                                               : Theme.flakeInactiveIndicator
                                                    }
                                                }
                                            }
                                        }

                                        MouseArea {
                                            id: netItemMouse
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: modelData.triggered()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}