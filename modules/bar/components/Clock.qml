import QtQuick
import Quickshell
import"../../.."

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
        color: Theme.clocktextCol
        font.family: Theme.clkFont
        font.bold: true
        font.pixelSize : Theme.clockfontsize
        anchors.leftMargin: 10
    }
}