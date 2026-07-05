import Quickshell
import QtQuick
import QtQuick.Effects
import "../../.."

Item {
    id: root
    property Item anchorItem 
    property var parentWindow 
    property int popupWidth: 250
    property int popupHeight: 300
    property bool isOpen: false
    property string src: ""
    property real imgOpac: 1
    property string anmtSrc: ""
    property bool blurEnabled: false
    property int blurMax: 0
    property real blur: 0.0
    property bool shadowEnabled: false
    property color shadowColor: "transparent"
    property real shadowBlur: 0.0
    property int shadowVerticalOffset: 0
    property real brightness: 0.0 
    property real contrast: 0.0
    property real saturation: 0.0
    property real colorization: 0.0
    property color colorizationColor: "transparent"
    
    property int popupAnchorEdges: Edges.Bottom
    property int popupAnchorGravity: Edges.Bottom

    property alias isHovered: popupHover.hovered
    default property alias menuContent: contentArea.data

    property int menuGap: 0

    Timer {
        id: closeTimer
        interval: 200
        onTriggered: actualPopup.visible = false
    }

    function open() { actualPopup.visible = true; isOpen = true; }
    function close() { if (!isOpen) return; isOpen = false; closeTimer.start(); }
    function toggle() { if (isOpen) close(); else open(); }

    property bool animatesLeft: false 

    PopupWindow {
        id: actualPopup
        grabFocus: false
        width: root.popupWidth
        height: root.popupHeight
        color: "transparent"
        visible: false

        anchor {
            window: root.parentWindow
            item: root.anchorItem
            margins.right: ((root.popupAnchorEdges & Edges.Right) !== 0) ? root.menuGap : 0
            margins.left: ((root.popupAnchorEdges & Edges.Left) !== 0) ? root.menuGap : 0
            margins.bottom: (root.popupAnchorEdges === Edges.Bottom) ? root.menuGap : 0
            
            edges: root.popupAnchorEdges
            gravity: root.popupAnchorGravity
            adjustment: PopupAdjustment.SlideX | PopupAdjustment.SlideY | PopupAdjustment.FlipX | PopupAdjustment.FlipY
        }

        Rectangle {
            id: growingBackground
            anchors.top: parent.top
            anchors.right: root.animatesLeft ? parent.right : undefined
            anchors.left: (!root.animatesLeft && root.popupAnchorEdges !== Edges.Bottom) ? parent.left : undefined
            anchors.horizontalCenter: (root.popupAnchorEdges === Edges.Bottom) ? parent.horizontalCenter : undefined
            
            width: root.isOpen ? root.popupWidth : 0
            height: root.isOpen ? root.popupHeight : 0
            opacity: root.isOpen ? 1 : 0
            
            color: Colors.popupCol
            radius: 8
            clip: true 
            border.width: 1
            border.color: "#FFFFFF"

            Behavior on width { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
            Behavior on height { NumberAnimation { duration: 150; easing.type: Easing.OutQuad } }
            Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.OutQuart } }

            HoverHandler { id: popupHover }

            Image {
                width: parent.width; height: parent.height; anchors.fill: parent
                fillMode: Image.PreserveAspectCrop; smooth: true; mipmap: true; antialiasing: true;
                source: src; opacity: imgOpac; layer.enabled: true
                layer.effect: MultiEffect {
                    blurEnabled: root.blurEnabled; blurMax: root.blurMax; blur: root.blur
                    shadowEnabled: root.shadowEnabled; shadowColor: root.shadowColor
                    shadowBlur: root.shadowBlur; shadowVerticalOffset: root.shadowVerticalOffset
                    brightness: root.brightness; contrast: root.contrast; saturation: root.saturation
                    colorization: root.colorization; colorizationColor: root.colorizationColor 
                }
            }
            
            AnimatedImage {
                width: parent.width; height: parent.height; anchors.fill: parent
                fillMode: Image.PreserveAspectCrop; smooth: true; mipmap: true; antialiasing: true;
                source: anmtSrc; opacity: imgOpac; layer.enabled: true
                layer.effect: MultiEffect {
                    blurEnabled: root.blurEnabled; blurMax: root.blurMax; blur: root.blur
                    shadowEnabled: root.shadowEnabled; shadowColor: root.shadowColor
                    shadowBlur: root.shadowBlur; shadowVerticalOffset: root.shadowVerticalOffset
                    brightness: root.brightness; contrast: root.contrast; saturation: root.saturation
                    colorization: root.colorization; colorizationColor: root.colorizationColor 
                }
            }
            
            Item {
                width: root.popupWidth; height: root.popupHeight
                
                anchors.top: parent.top
                anchors.right: root.animatesLeft ? parent.right : undefined
                anchors.left: (!root.animatesLeft && root.popupAnchorEdges !== Edges.Bottom) ? parent.left : undefined
                anchors.horizontalCenter: (root.popupAnchorEdges === Edges.Bottom) ? parent.horizontalCenter : undefined
                
                Item { id: contentArea; anchors.fill: parent; anchors.margins: 10 }
            }
        }
    }
}