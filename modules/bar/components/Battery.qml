import Quickshell
import QtQuick
import Quickshell.Services.UPower
import "../../.."

ArrowShape{
    width : 120
    height : 30


    Row{
        anchors.centerIn : parent
        spacing : 5
        Image{
            width : 21
            height : 21
            source : if(!UPower.onBattery){
                "svgs/battery/batteryCharging.svg"
            }else if(UPower.displayDevice.percentage >= 0.75){
                "svgs/battery/batteryFull.svg"
            }else if(UPower.displayDevice.percentage >= 0.4 && UPower.displayDevice.percentage < 0.75){
                'svgs/battery/batteryMid.svg'
            }else if(UPower.displayDevice.percentage < 0.4){
                "svgs/battery/batteryLow.svg"
            }else{
                "svgs/batter/batteryDed.svg"
            }
            anchors.verticalCenter : parent.verticalCenter
            antialiasing : true
            mipmap : true
            smooth : true
            rotation : -90
        }

        Text{
            font.pixelSize : Theme.batfontsize
            font.bold : true
            font.family: Theme.batfontfamily
            color : Theme.battextCol
            text: (UPower.displayDevice.percentage*100).toFixed(0) + "%"
            anchors.verticalCenter : parent.verticalCenter
        }
    }
}