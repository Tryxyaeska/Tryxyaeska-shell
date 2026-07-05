import Quickshell
import QtQuick
import "components"
import "notifications"
import "../.."

PanelWindow{
    id: statusBar

    anchors{
        top : true
        left : true
        right : true
    }

    implicitHeight: 30
    color : Colors.barBg

    
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        height : parent.height
        width : parent.width
        Rectangle {
            id: bottomBorder
            width: parent.width
            height: 2 
            color: '#ffffff' 
            anchors.top: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Row{
            spacing : 20
            id : left
            anchors.left : parent.left
            anchors.verticalCenter: parent.verticalCenter
            height : parent.height
            anchors.leftMargin : 30
            Row{
                anchors.verticalCenter: parent.verticalCenter
                height : parent.height
                Clock{}
                anchors.leftMargin : 30
            }
            Row{
                anchors.verticalCenter: parent.verticalCenter
                height : parent.height
                anchors.leftMargin : 450
                WorkSpaces{}
            }
        }

        Row{
            id : centre
            anchors.verticalCenter : parent.verticalCenter
            height : parent.height
            anchors.horizontalCenter : parent.horizontalCenter
            Row{
                id : cpuStats
                anchors.verticalCenter : parent.verticalCenter
                anchors.leftMargin : 700
                Cpu{}
            }
            Row{
                id : btMain
                anchors.verticalCenter : parent.verticalCenter
                Bluetooth{}
            }
            Row{
                id : mpris
                anchors.verticalCenter : parent.verticalCenter
                // anchors.leftMargin : 450
                height : parent.height
                Mpris{}
            }
            Row{
                id: networkMain
                anchors.verticalCenter : parent.verticalCenter
                InternetConns{}
            }
            Row{
                id : batteryStats
                anchors.verticalCenter : parent.verticalCenter
                anchors.rightMargin : 700
                Battery{}
            }
        }

        Row{
            id : right
            anchors.right : parent.right
            anchors.verticalCenter : parent.verticalCenter
            anchors.rightMargin : 30
            height : parent.height
            spacing : 20
            Row{
                id : pulsewire
                anchors.verticalCenter : parent.verticalCenter
                anchors.rightMargin : 450
                height : parent.height
                PulseWire{}
            }
            Row{
                id : systemTray
                anchors.verticalCenter : parent.verticalCenter
                height : parent.height
                Tray{}
            }
        }
    }

    Rectangle{
        id : notifAnchor
        height : parent.height
        width : 10
        anchors.right : parent.right
        anchors.top : parent.top
        color : "transparent"
        Notif{}
    }
}