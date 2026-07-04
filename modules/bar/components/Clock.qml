import QtQuick
import Quickshell

ArrowShape{
    height: parent.height
    width: clkText.implicitWidth + 30

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
    Text{   
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter : parent.horizontalCenter
        id : clkText
        text: Qt.formatDateTime(clock.date, "dd-MM-yyyy | hh:mm ")
        color: '#FFFFFF'
        font.bold: true
        font.pixelSize : 14
        anchors.leftMargin: 10
    }
}