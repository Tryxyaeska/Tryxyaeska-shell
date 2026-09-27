import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Widgets
import "../../.."

PanelWindow {
    id: flakeWindow

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
        acceptedButtons : Qt.AllButtons
        onClicked: (mouse) => {
            if(mouse.button == Qt.RightButton){
                mainFlake.visible = false
            }else if(mouse.button == Qt.LeftButton){
                mainFlake.visible = false
            }
        }
    }

    Item {
        id: flakeContainer
        width: 700
        height: 300
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 30

        MouseArea {
            anchors.fill: parent
        }

        Column {
            id: connector
            anchors.fill: parent
            spacing: 0

            Rectangle {
                width: parent.width
                height: 5
                color: Theme.barBg
            }

            FlakeShape {
                width: parent.width
                height: parent.height - 5
                slantOffset: 80
                cornerRadius: 24
            }
        }
    }
}