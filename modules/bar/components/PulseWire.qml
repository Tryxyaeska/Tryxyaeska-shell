import Quickshell
import QtQuick
import Quickshell.Io
import Quickshell.Services.Pipewire
import "../../.."

ArrowShape{
    id : pulseMain
    height : parent.height
    width : 176
    arrowLeft : -1
    arrowRight : -1

    PwObjectTracker{
        objects : [Pipewire.defaultAudioSink]
    }

    property real currAudioSinkVolume : Pipewire.defaultAudioSink.audio.volume
    property bool currAudioSinkMuted : Pipewire.defaultAudioSink.audio.muted
    property real volumeDb : currAudioSinkVolume > 0 ? (60*Math.log10(currAudioSinkVolume)).toFixed(2) : "-Inf"

    Process {
        id: openPavucontrol
        command: ["sh", "-c", "pavucontrol &"]
    }

    Row{
        anchors.centerIn : parent
        spacing : 10

        Rectangle{
            anchors.verticalCenter : parent.verticalCenter
            height : 20
            width : 20
            color : "transparent"

            Image{
                height : parent.height
                width : parent.width
                fillMode : Image.PreserveAspectFit
                opacity : Pipewire.defaultAudioSink.nickname === "Speaker" ? 1 : 0
                source : if(currAudioSinkMuted){
                    source : "svgs/pulsewire/speakerMute2.svg"
                }else if(currAudioSinkVolume >= 0.74){
                    source : "svgs/pulsewire/speakerFull.svg"
                }else if(currAudioSinkVolume >= 0.30){
                    source : "svgs/pulsewire/speakerMid.svg"
                }else{
                    source : "svgs/pulsewire/speakerLow.svg"
                }
            }

            Image{
                height : parent.height
                width : parent.width
                fillMode : Image.PreserveAspectFit
                opacity : Pipewire.defaultAudioSink.nickname === "Headphones" ? 1 : 0
                smooth : true; mipmap : true; antialiasing : true;
                source : "svgs/pulsewire/headphone.svg"
            }
        }
        Row{
            anchors.verticalCenter : parent.verticalCenter
            spacing : 10
            Text{
                anchors.verticalCenter : parent.verticalCenter
                font.pixelSize : Theme.pulseVolfontsize
                font.family: Theme.pulseFont
                font.bold : true
                color : Theme.pulseVolfontCol
                text : Math.round(currAudioSinkVolume * 100) + "%"   
            }
            Text{
                anchors.verticalCenter : parent.verticalCenter
                font.pixelSize : Theme.pulseDBfontsize
                font.family: Theme.pulseDBFont
                font.bold : true
                color : Theme.pulseDBfontCol
                text : if(volumeDb > 0){
                    "+" + volumeDb + "dB"
                    }else if(volumeDb < 0 && volumeDb !="-Inf"){
                        "-" + volumeDb * (-1) + "dB"
                    }else if(volumeDb === 0){
                        volumeDb + "dB"
                    }else{
                        "-Inf dB"
                    }
            }
        }
    }
    MouseArea {
        id: pipeWireCtrl
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.AllButtons
        onClicked: (mouse) => {
            if(mouse.button == Qt.RightButton){
                Pipewire.defaultAudioSink.audio.muted = !currAudioSinkMuted
            }else if(mouse.button == Qt.MiddleButton){
                openPavucontrol.running = false 
                openPavucontrol.running = true
            }
        }
        onWheel: (wheel)=> {
            if(wheel.angleDelta.y > 0){
                Pipewire.defaultAudioSink.audio.volume = Math.min(1.5, Pipewire.defaultAudioSink.audio.volume += 0.01)
            }else if(wheel.angleDelta.y < 0){
                Pipewire.defaultAudioSink.audio.volume = Math.max(0, Pipewire.defaultAudioSink.audio.volume -= 0.01)
            }
        }
    }
}