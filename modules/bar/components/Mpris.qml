import Quickshell
import QtQuick
import Quickshell.Services.Mpris
import "../../.."

ArrowShape{
    id : pulseMain
    height : parent.height
    width : 200
    arrowLeft : 1
    arrowRight : 1
    property var sources : Mpris.players.values
    property var spotifyMpris : sources.filter(x => x.identity === "Spotify")
    
    Item {
        id: textWrapper
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        height: parent.height
        
        Text {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 14
            font.bold: true
            color: Colors.fontCol
            text: {
                if(spotifyMpris.length > 0) {
                    spotifyMpris[0].trackTitle + " - " + spotifyMpris[0].trackArtist
                }else if (sources.length > 0 && sources[0].trackTitle.length != 0) {
                    sources[0].trackTitle + " - " + sources[0].trackArtist
                }else{
                    "MPRIS - Offline"
                }
            }
            elide: Text.ElideRight
        }
    }
}