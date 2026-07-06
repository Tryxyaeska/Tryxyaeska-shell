import Quickshell
import QtQuick
import Quickshell.Io
import "ArrowShape"
import "../../.."

ArrowShape { 
    id: root
    height: 30
    width: 120
    arrowLeft : 1
    arrowRight : -1
    arrowDepth : 12
    property string usageText: "0%"
    property string tempText: "0°C"
    property var lastCpuIdle: 0
    property var lastCpuTotal: 0

    Process {
        id: cpuUsage
        command: ["head", "-n", "1", "/proc/stat"]
        
        stdout: SplitParser {
            onRead: data => {
                if (!data) return;
                
                let parts = data.trim().split(/\s+/);
                let user = parseInt(parts[1]) || 0;
                let nice = parseInt(parts[2]) || 0;
                let system = parseInt(parts[3]) || 0;
                let idle = parseInt(parts[4]) || 0;
                let iowait = parseInt(parts[5]) || 0;
                let irq = parseInt(parts[6]) || 0;
                let softirq = parseInt(parts[7]) || 0;

                let total = user + nice + system + idle + iowait + irq + softirq;
                let idleTime = idle + iowait;

                if (root.lastCpuTotal > 0) {
                    let totalDiff = total - root.lastCpuTotal;
                    let idleDiff = idleTime - root.lastCpuIdle;
                    if (totalDiff > 0) {
                        root.usageText = Math.round(100 * (totalDiff - idleDiff) / totalDiff) + "%";
                    }
                }
                
                root.lastCpuTotal = total;
                root.lastCpuIdle = idleTime;
            }
        }
    }

    Process {
        id: cpuTemp
        command: ["bash", "-c", "/usr/bin/sensors | grep -A 2 'acpitz' | awk '/temp1/ {print $2}' | tr -d '+' | head -n 1"]
        
        stdout: SplitParser {
            onRead: data => {
                if (data && data.trim() !== "") {
                    root.tempText = data.trim(); 
                }
            }
        }
    }

    Component.onCompleted: {
        cpuUsage.running = true;
        cpuTemp.running = true;
    }

    Timer {
        id: repeater4Change
        interval: 3000
        running: true
        repeat: true
        onTriggered: {
            cpuUsage.running = true;
            cpuTemp.running = true;
        }
    }

    Row {
        spacing: 12
        anchors.centerIn: parent

        Text {
            text: root.usageText
            font.pixelSize: Theme.cpuUsagefontsize
            font.bold: true
            color: Theme.cpuUsagetextCol
            font.family: Theme.cpuFont
        }

        Text {
            text: root.tempText
            font.pixelSize: Theme.cpuTempfontsize
            font.bold: true
            color: Theme.cpuTemptextcol
            font.family: Theme.cpuFont
        }
    }
}