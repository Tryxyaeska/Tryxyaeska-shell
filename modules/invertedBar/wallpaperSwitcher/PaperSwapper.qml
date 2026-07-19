import Quickshell
import QtQuick
import Quickshell.Io
import QtQuick.Effects
import "../"

Item{
    id : paperSwapperAnchor
    height : parent.height
    width : parent.width
    anchors.fill : parent
    property bool visibility

    Process{
        id: osCommand
        property string cmd: ""
        command: ["bash", "-c", cmd]
    }

    Rectangle{
        id : paperSwapperAnchorRect
        anchors.fill : parent
        height : parent.height ; width : parent.width
        color : "black"

        MouseArea {
            anchors.fill: parent
            hoverEnabled : true
        }

        HoverHandler{
            onHoveredChanged: {
                if(hovered){
                    visibility = true
                }else{
                    closeTimer.restart()
                }
            }
        }
    }
    
    PanelWindow{
        id: paperCenterMain
        anchors {
            bottom : true
        }
        margins {
            bottom : 96
        }
        property var wallpaperDb: [
            "/mnt/data/Utility OG/Pictures/images.steamusercontent (9).jpg",
            "/mnt/data/Utility OG/Pictures/images.steamusercontent (7).jpg",
            "/mnt/data/Utility OG/Pictures/download (70) (Edited) (3).jpg",
            "/mnt/data/Utility OG/Pictures/destiny (5).jpg",
            "/mnt/data/Utility OG/Pictures/nierRainOptimized.jpg",
            "/mnt/data/Utility OG/Pictures/nier-2b-gif.gif",
            "/mnt/data/Utility OG/Pictures/halo_by_rikenz15_d6p7rqf.png",
            "/mnt/data/Utility OG/Pictures/nier-4.jpg"
        ]
        property int currentIndex: 0
        property int lastIndex: 0
        property int slideDirection: 1 

        onCurrentIndexChanged : {
            let maxIndex = wallpaperDb.length - 1
            if(lastIndex === maxIndex && currentIndex === 0){
                slideDirection = 1
            } else if (lastIndex === 0 && currentIndex === maxIndex){
                slideDirection = -1
            } else{
                slideDirection = currentIndex > lastIndex ? 1 : -1
            }
            
            lastIndex = currentIndex
        }

        function handleScroll(wheel){
            let maxIndex = wallpaperDb.length - 1
            if(maxIndex < 0) return

            if (wheel.angleDelta.y > 0 || wheel.angleDelta.x > 0){
                currentIndex = (currentIndex > 0) ? currentIndex - 1 : maxIndex
            } else{
                currentIndex = (currentIndex < maxIndex) ? currentIndex + 1 : 0
            }
        }

        implicitWidth : visibility ? 1260 : 0
        implicitHeight : visibility ? 200 : 200
        Behavior on implicitWidth {NumberAnimation {duration: 50; easing.type: Easing.InOutBack}}
        Behavior on implicitHeight {NumberAnimation {duration: 50; easing.type: Easing.InOutBack}}
        color : "transparent"
        exclusionMode : ExclusionMode.Ignore
        
        Timer {
            id: closeTimer
            interval: 600
            onTriggered: visibility = false
        }

        HoverHandler {
            onHoveredChanged: {
                if (hovered) {
                    closeTimer.stop()
                } else {
                    closeTimer.restart()
                }
            }
        }

        Item{
            anchors.fill : parent
            clip : true
            Rectangle{
                color : "transparent"
                height : parent.height
                width : parent.width
                Image{
                    width: parent.width; height: parent.height; anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop; smooth: true; mipmap: true; antialiasing: true;
                    source: "/mnt/data/Utility OG/Pictures/destiny# (4).jpg"; 
                    opacity: 0.433; layer.enabled: true
                    layer.effect: MultiEffect {
                        blurEnabled: true; blurMax: 8; blur: 0.6
                        shadowEnabled: false; shadowColor: "#000000"
                        shadowBlur: 0; shadowVerticalOffset: 0
                        brightness: 0; contrast: 0.233; saturation: 0.333
                        colorization: 0.2; colorizationColor: "#1e1e2e"
                    }
                }
            }
        }

        ArrowShape{
            id : arrowShapeMain
            width : parent.width
            height : parent.height
            boxColor : '#000000'
            arrowLeft : -1
            arrowRight : -1
            arrowDepth : 56
        
        }
        ArrowShape{
            id : leftBorderArrow
            width : 60
            height : parent.height
            boxColor : "white"
            arrowLeft : -1
            arrowRight : 1
            arrowDepth : 56
            anchors.left : parent.left
        }
        Rectangle{
            id : topBorderRect
            width : parent.width -4
            height : 3
            anchors.top : parent.top
            anchors.horizontalCenter : parent.horizontalCenter
            color : "white"
        }
        ArrowShape{
            id : rightBorderArrow
            width : 60
            height : parent.height
            boxColor : "white"
            arrowLeft : 1
            arrowRight : -1
            arrowDepth : 56
            anchors.right : parent.right
        }
        Rectangle{
            id : bottomBorderRect
            width : parent.width -4
            height : 3
            anchors.bottom : parent.bottom
            anchors.horizontalCenter : parent.horizontalCenter
            color : "white"
        }

        ArrowShape{
            id : addWallpaperArrow
            width: 300
            height: parent.height - 6
            anchors.right: parent.right
            anchors.verticalCenter : parent.verticalCenter
            anchors.margins : { right : 4 }
            boxColor: "#434343"
            arrowLeft: 1
            arrowRight: -1
            arrowDepth: 56
            imageSource : "/mnt/data/Utility OG/Pictures/D0UXGhbW0AI7KWS.jpg"
            imageOpacity : 0.77
            
            Text{
                anchors.centerIn: parent
                text: "ADD"
                color: "white"
                font.family: "Orbitron"
                font.pixelSize: 24
                font.bold: true
            }

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked:{ }
            }
        }

        ArrowShape{
            id: addDividerArrow
            width: 60
            height: parent.height - 6
            anchors.right: addWallpaperArrow.left
            anchors.verticalCenter : parent.verticalCenter
            anchors.margins : {right : -30}
            boxColor: "white"
            arrowLeft: 1
            arrowRight: -1
            arrowDepth: 56
        }

        ArrowShape{
            id : leftWallpaperArrow
            width: 300
            height: parent.height - 6
            anchors.left: parent.left
            anchors.verticalCenter : parent.verticalCenter
            anchors.margins : { left : 4 }
            boxColor: "#434343"
            arrowLeft: -1
            arrowRight: 1
            arrowDepth: 56
            slideDirection: paperCenterMain.slideDirection
            imageSource: paperCenterMain.currentIndex > 0 ? paperCenterMain.wallpaperDb[paperCenterMain.currentIndex - 1] : paperCenterMain.wallpaperDb.length > 0 ? paperCenterMain.wallpaperDb[paperCenterMain.wallpaperDb.length - 1] : ""
            imageOpacity: leftMouse.containsMouse ? 0.9 : 0.5
            Behavior on imageOpacity{
                NumberAnimation{
                    duration : 120
                    easing.type : Easing.OutQuad
                }
            }

            MouseArea{
                id : leftMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked : { 
                    let maxIndex = paperCenterMain.wallpaperDb.length - 1
                    paperCenterMain.currentIndex = (paperCenterMain.currentIndex > 0) ? paperCenterMain.currentIndex - 1 : maxIndex
                }
                onWheel : (wheel) => paperCenterMain.handleScroll(wheel)
            }
        }

        ArrowShape{
            id: leftDividerArrow
            width: 60
            height: parent.height - 6
            anchors.left: leftWallpaperArrow.right
            anchors.verticalCenter : parent.verticalCenter
            anchors.margins : {left : -30}
            boxColor: "white"
            arrowLeft: -1
            arrowRight: 1
            arrowDepth: 56
        }

        ArrowShape{
            id : rightWallpaperArrow
            width: 300
            height: parent.height - 6
            anchors.right: addWallpaperArrow.left
            anchors.verticalCenter : parent.verticalCenter
            anchors.margins : { right : -26 }
            boxColor: "#434343"
            arrowLeft: 1
            arrowRight: -1
            arrowDepth: 56
            slideDirection: paperCenterMain.slideDirection
            imageSource: paperCenterMain.currentIndex < paperCenterMain.wallpaperDb.length - 1 ? paperCenterMain.wallpaperDb[paperCenterMain.currentIndex + 1] : paperCenterMain.wallpaperDb.length > 0 ? paperCenterMain.wallpaperDb[0] : ""
            imageOpacity: rightMouse.containsMouse ? 0.73 : 0.5
            Behavior on imageOpacity{
                NumberAnimation{
                    duration : 120
                    easing.type : Easing.OutQuad
                }
            }

            MouseArea{
                id : rightMouse
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked : { 
                    let maxIndex = paperCenterMain.wallpaperDb.length - 1
                    paperCenterMain.currentIndex = (paperCenterMain.currentIndex < maxIndex) ? paperCenterMain.currentIndex + 1 : 0
                }
                onWheel : (wheel) => paperCenterMain.handleScroll(wheel)
            }
        }

        ArrowShape{
            id: rightDividerArrow
            width: 60
            height: parent.height - 6
            anchors.right: rightWallpaperArrow.left
            anchors.verticalCenter : parent.verticalCenter
            anchors.margins : {left : -30}
            boxColor: "white"
            arrowLeft: 1
            arrowRight: -1
            arrowDepth: 56
        }

        ArrowShape{
            id : centreWallpaperArrow
            height: parent.height - 6
            anchors.left: leftDividerArrow.right
            anchors.right : rightDividerArrow.left
            anchors.verticalCenter : parent.verticalCenter
            anchors.margins : { right : -24; left : -24 }
            boxColor: "#434343"
            arrowLeft: -1
            arrowRight: -1
            arrowDepth: 56
            slideDirection: paperCenterMain.slideDirection
            imageSource: paperCenterMain.wallpaperDb.length > 0 ? paperCenterMain.wallpaperDb[paperCenterMain.currentIndex] : ""
            imageOpacity: 1.0

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked:{ 
                    osCommand.cmd = "~/.config/quickshell/modules/invertedBar/wallpaperSwitcher/scripts/loadPaper.sh '" + paperCenterMain.wallpaperDb[paperCenterMain.currentIndex] + "'"
                    osCommand.running = true
                }
                onWheel : (wheel) => paperCenterMain.handleScroll(wheel)
            }
        }

        ArrowShape{
            id: centreRightDividerArrow
            width: 60
            height: parent.height - 6
            anchors.right: centreWallpaperArrow.left
            anchors.verticalCenter : parent.verticalCenter
            anchors.margins : {right : -56}
            boxColor: "white"
            arrowLeft: -1
            arrowRight: 1
            arrowDepth: 56
        }

        ArrowShape{
            id: centreLeftDividerArrow
            width: 60
            height: parent.height - 6
            anchors.left: centreWallpaperArrow.right
            anchors.verticalCenter : parent.verticalCenter
            anchors.margins : {left : -56}
            boxColor: "white"
            arrowLeft: 1
            arrowRight: -1
            arrowDepth: 56
        }
    }
}