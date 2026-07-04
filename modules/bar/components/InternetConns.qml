import Quickshell
import QtQuick
import Quickshell.Networking
import Quickshell.Widgets
import Quickshell.Io
import Quickshell.Services.SystemTray

Item {
    height: 30
    width: 50
    id: networkMain

    ArrowShape {
        id: mainButton
        border : 1
        width: 50
        height: 30

        Image {
            anchors.centerIn: parent
            width: 20
            height: 20
            fillMode: Image.PreserveAspectFit
            source: if(Networking.devices.values.filter(d => d.type === DeviceType.Wired).filter(y => y.connected).length > 0){
                        "svgs/network/wired.svg"
                    }else if(Networking.wifiEnabled){
                        if(getWifiStrength(networkMain.currentWifiName) * 100 >= 75){
                            "svgs/network/wifi (4).svg"
                        }else if(getWifiStrength(networkMain.currentWifiName) * 100 >= 50){
                            "svgs/network/wifi (3).svg"
                        }else if(getWifiStrength(networkMain.currentWifiName) * 100 >= 25){
                            "svgs/network/wifi (2).svg"
                        }else if(getWifiStrength(networkMain.currentWifiName) * 100 < 25 && getWifiStrength(networkMain.currentWifiName) * 100 > 0){
                            "svgs/network/wifi (1).svg"
                        }else{
                            "svgs/network/disconnected.svg"
                        }
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

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: myPopup.toggle() 
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
        popupWidth: 500
        popupHeight: 300
        menuGap : -2
        // anmtSrc: '/mnt/data/Utility OG/Pictures/nier-2b-gif.gif'
        src : "/home/origin/Downloads/kurisu.jpg"
        blurEnabled : true
        blur : 0.6
        blurMax : 10
        contrast : 0.5
        saturation : 0.7
        imgOpac : 0.5
        brightness : 0.3
        colorization : 0.46
        colorizationColor : '#5e2e0e'

        Process {
            id: osCommand
            property string cmd: ""
            command: ["bash", "-c", cmd]
        }

        Row {
            id: mainRow
            anchors.fill: parent
            anchors.margins: 15
            spacing: 20

            Column {
                id: menuLayout
                width: 210
                spacing: 4
                
                Row {
                    id: row1
                    width: parent.width
                    spacing: 30
                
                    //Turn Wifi ON/OFF
                    Rectangle {
                        width: 50; height: 50; color: btn1.containsMouse ? "#313244" : "transparent"; radius: 5;
                        
                        Image { 
                            anchors.centerIn: parent; width: 28; height: 28; fillMode: Image.PreserveAspectFit; smooth : true; mipmap : true; antialiasing: true;
                            source: "svgs/network/wifi (4).svg"
                            opacity: (Networking.wifiEnabled) ? 1 : 0
                            Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
                        }
                        Image { 
                            anchors.centerIn: parent; width: 28; height: 28; fillMode: Image.PreserveAspectFit; smooth : true; mipmap : true; antialiasing: true;
                            source: "svgs/network/wifiOff.svg"
                            opacity: (Networking.wifiEnabled) ? 0 : 1
                            Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
                        }
                        
                        MouseArea { 
                            id: btn1
                            anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                osCommand.cmd = "nmcli radio wifi | grep -q 'enabled' && nmcli radio wifi off || nmcli radio wifi on"
                                osCommand.running = true
                            }
                        }
                    }

                    //Networking ON/OFF Toggle
                    Rectangle {
                        id: netContainer
                        width: 50; height: 50; color: btn2.containsMouse ? "#313244" : "transparent"; radius: 5
                        property bool isNetOn: Networking.wifi ? Networking.wifiEnabled : true
                        
                        Image { 
                            anchors.centerIn: parent; width: 28; height: 28; fillMode: Image.PreserveAspectFit; smooth : true; mipmap : true; antialiasing: true;
                            source: "svgs/network/networkOn.svg"
                            opacity: netContainer.isNetOn ? 1 : 0
                            Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
                        }
                        
                        Image { 
                            anchors.centerIn: parent; width: 28; height: 28; fillMode: Image.PreserveAspectFit; smooth : true; mipmap : true; antialiasing: true;
                            source: "svgs/network/networkOff.svg"
                            opacity: netContainer.isNetOn ? 0 : 1
                            Behavior on opacity { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
                        }
                        
                        MouseArea { 
                            id: btn2; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                            onClicked: { 
                                netContainer.isNetOn = !netContainer.isNetOn
                                osCommand.cmd = "nmcli networking | grep -q 'enabled' && nmcli networking off || nmcli networking on"
                                osCommand.running = true 
                            } 
                        }
                    }

                    //Edit Connections
                    Rectangle {
                        width: 50; height: 50; color: btn3.containsMouse ? "#313244" : "transparent"; radius: 5
                        Image { anchors.centerIn: parent; width: 24; height: 24; smooth : true; mipmap : true; antialiasing: true; fillMode: Image.PreserveAspectFit; source: "svgs/network/edit.svg" }
                        MouseArea { 
                            id: btn3; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                            onClicked: { osCommand.cmd = "nm-connection-editor"; osCommand.running = true; myPopup.toggle() } 
                        }
                    }
                }

                Item { width: 1; height: 1 } 

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 1
                    width: 190
                    color: '#5a5b65'
                }

                Item { width: 1; height: 1 }

                Row {
                    id: row2
                    width: parent.width
                    spacing: 30
                
                    //Connection Information
                    Rectangle {
                        width: 50; height: 50; color: btn5.containsMouse ? "#313244" : "transparent"; radius: 5;
                        Image { anchors.centerIn: parent; width: 28; height: 28; fillMode: Image.PreserveAspectFit; smooth : true; mipmap : true; antialiasing: true; source: "svgs/network/info.svg" }
                        MouseArea { 
                            id: btn5; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                            onClicked: { osCommand.cmd = "nm-connection-editor"; osCommand.running = true; myPopup.toggle() } 
                        }
                    }

                    //Connect To a Hidden Network
                    Rectangle {
                        width: 50; height: 50; color: btn6.containsMouse ? "#313244" : "transparent"; radius: 5
                        Image { anchors.centerIn: parent; width: 28; height: 28; smooth : true; mipmap : true; antialiasing: true; fillMode: Image.PreserveAspectFit; source: "svgs/network/hidden.svg" }
                        MouseArea { 
                            id: btn6; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                            onClicked: { osCommand.cmd = "nm-connection-editor -c -t 802-11-wireless"; osCommand.running = true; myPopup.toggle() } 
                        }
                    }

                    //Create New Wifi Network
                    Rectangle {
                        width: 50; height: 50; color: btn7.containsMouse ? "#313244" : "transparent"; radius: 5
                        Image { anchors.centerIn: parent; width: 28; height: 28; smooth : true; mipmap : true; antialiasing: true; fillMode: Image.PreserveAspectFit; source: "svgs/network/create.svg" }
                        MouseArea { 
                            id: btn7; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                            onClicked: { osCommand.cmd = "nm-connection-editor -c -t 802-11-wireless"; osCommand.running = true; myPopup.toggle() } 
                        }
                    }
                }

                Item { width: 1; height: 1 } 

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 1
                    width: 190
                    color: '#5a5b65'
                }

                Item { width: 1; height: 1 }

                Column {
                    id: wiredSpace
                    width: parent.width
                    spacing: 10

                    Rectangle {
                        width: parent.width
                        height: 30
                        color: "transparent"
                        
                        Text {
                            anchors.verticalCenter: parent.verticalCenter 
                            anchors.left: parent.left
                            anchors.leftMargin: 5
                            font.pixelSize: 14
                            font.bold: true
                            color: "#a6adc8"
                            text: "Wired/ Ethernet Networks:"
                        }
                    }

                    Column {
                        width: parent.width
                        spacing: 10
                        property var wiredDevices: Networking.devices ? Networking.devices.values.filter(d => d.type === DeviceType.Wired).sort((a, b) => b.connected - a.connected) : []
                        
                        Repeater {
                            model: parent.wiredDevices
                            
                            delegate: Row {
                                width: parent.width
                                spacing: 10
                                anchors.left: parent.left
                                anchors.leftMargin: 5  
                                
                                Image {
                                    source: "svgs/network/ethernet.svg" 
                                    width: 20
                                    height: 20
                                    anchors.verticalCenter: parent.verticalCenter
                                    opacity: modelData.connected ? 1.0 : 0.4
                                }
                                
                                Text { 
                                    anchors.verticalCenter: parent.verticalCenter
                                    text: modelData.name 
                                    font.pixelSize: 14
                                    font.bold: true
                                    color: modelData.connected ? '#57c84f' : '#8b8b8b' 
                                }
                            }
                        }
                    }
                }
            }

            // Separator line
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
                width: 1
                color: '#5a5b65'
            }
            
            Column {
                id: wifiMenuColumn
                height: parent.height
                width: parent.width - menuLayout.width - 1 - (mainRow.spacing * 2) 
                spacing: 5

                property var wifiAdapter: Networking.devices ? Networking.devices.values.find(d => d.type === DeviceType.Wifi) : null

                Rectangle {
                    width: parent.width; height: 24; color: "transparent"; radius: 5;
                    Text { anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 18; font.bold: true; padding: 5; color: "white"; text: "Wi-Fi"; }
                }

                //Currently Connected Header
                Rectangle {
                    width: parent.width; height: 30; color: "transparent"; radius: 5;
                    Text { anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 14; font.bold: true; padding: 5; color: "#a6adc8"; text: "Current"; }
                }

                //Active Connected Wi-Fi Network
                Rectangle {
                    width: parent.width; height: 35; color: "transparent"; radius: 5;
                    
                    Text { 
                        anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 14; font.bold: true; padding: 5; color: "#f38ba8";
                        text: "Disconnected"
                        visible: connectedRepeater.count === 0
                    }
                    
                    Row {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left; anchors.leftMargin: 5
                        
                        Repeater {
                            id: connectedRepeater
                            model: wifiMenuColumn.wifiAdapter ? wifiMenuColumn.wifiAdapter.networks : null
                            
                            delegate: Row {
                                spacing: 10
                                visible: modelData.connected === true 
                                
                                Image { 
                                    source: "svgs/network/wifi (4).svg" 
                                    width: 16; height: 16; anchors.verticalCenter: parent.verticalCenter 
                                }
                                Text { 
                                    text: modelData.name ? modelData.name : "Connected"
                                    font.pixelSize: 14; font.bold: true; color: "#a6e3a1"; anchors.verticalCenter: parent.verticalCenter 
                                }
                            }
                        }
                    }
                }

                //Divider
                Rectangle { width: parent.width; height: 1; color: "#5a5b65" }

                //Search Available Networks Button
                Rectangle {
                    id: scanContainer
                    width: parent.width; height: 35; radius: 5;
                    color: scanMouse.containsMouse ? "#313244" : "transparent"
                    
                    property bool isScanning: false

                    Process {
                        id: fetchNetworks
                        command: ["bash", "-c", "nmcli -t -f ACTIVE,SIGNAL,SSID dev wifi"]
                    }
                    
                    Text { 
                        anchors.verticalCenter: parent.verticalCenter; anchors.left: parent.left; anchors.leftMargin: 5;
                        font.pixelSize: 14; font.bold: true; 
                        color: scanContainer.isScanning ? "#a6adc8" : "#a6adc8"; 
                        text: scanContainer.isScanning ? "Available Networks (SCNG)" : "Available Networks (RSCN)"
                        Behavior on color { ColorAnimation { duration: 150 } }
                    }

                    Connections {
                        target: myPopup
                        function onIsOpenChanged() {
                            if (myPopup.isOpen === true) {
                                if (!scanContainer.isScanning && Networking.wifiEnabled) {
                                    scanContainer.isScanning = true;
                                    osCommand.cmd = "nmcli device wifi rescan";
                                    osCommand.running = true;
                                    scanTimer.start();
                                }
                            }
                        }
                    }

                    MouseArea {
                        id: scanMouse
                        anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (!scanContainer.isScanning) {
                                scanContainer.isScanning = true;
                                osCommand.cmd = "nmcli device wifi rescan";
                                osCommand.running = true;
                                scanTimer.start();
                            }
                        }
                    }
                    
                    Timer { id: scanTimer; interval: 5000; onTriggered: scanContainer.isScanning = false }
                }
                
                //List of all Available Connections
                Flickable {
                    width: parent.width
                    height: parent.height - 140 
                    contentHeight: availColumn.height
                    clip: true

                    QsMenuOpener {
                        id: netWorkMainTray
                        menu: SystemTray.items.values.filter(x => x.title === "Network")[0].menu
                    }
                    QsMenuOpener {
                        id: avlConnsMain
                        menu: netWorkMainTray.children.values.filter(x => x.text === "Available networks")[0]
                    }

                    Column {
                        id: availColumn
                        width: parent.width
                        spacing: 2
                        
                        Repeater {
                            model: avlConnsMain.children.values
                            delegate: Rectangle {
                                width: parent.width; height: 35; radius: 5; 
                                color: avlNetworkMouse.containsMouse ? "#313244" : "transparent"
                                
                                Row {
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left; anchors.leftMargin: 5; spacing: 10
                                    
                                    Image {
                                        width: 16; height: 16; opacity: 0.85; anchors.verticalCenter: parent.verticalCenter 
                                        source: if(Networking.wifiEnabled){
                                            if(getWifiStrength(modelData.text) * 100 >= 75){
                                                "svgs/network/wifi (4).svg"
                                            }else if(getWifiStrength(modelData.text) * 100 >= 50){
                                                "svgs/network/wifi (3).svg"
                                            }else if(getWifiStrength(modelData.text) * 100 >= 25){
                                                "svgs/network/wifi (2).svg"
                                            }else{
                                                "svgs/network/wifi (1).svg"
                                            }
                                        }
                                    }
                                    Text {
                                        font.pixelSize: 14; font.bold: false; color: "white"; anchors.verticalCenter: parent.verticalCenter 
                                        text: modelData.text
                                    }
                                }
                                MouseArea {
                                    id: avlNetworkMouse
                                    anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        modelData.triggered()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    property string currentWifiName: {
        let wifiAdapter = Networking.devices ? Networking.devices.values.find(d => d.type === DeviceType.Wifi) : null;
        if (!wifiAdapter || !wifiAdapter.networks) return "Disconnected";
        let activeNet = wifiAdapter.networks.values.find(n => n.connected === true);
        return activeNet ? activeNet.name : "Disconnected";
    }
    function getWifiStrength(networkName){
        let wifiAdapter = Networking.devices ? Networking.devices.values.find(d => d.type === DeviceType.Wifi) : null;
        if (!wifiAdapter || !wifiAdapter.networks) return 0;
        let targetNet = wifiAdapter.networks.values.find(n => n.name === networkName);
        return targetNet ? targetNet.signalStrength : 0;
    }
}