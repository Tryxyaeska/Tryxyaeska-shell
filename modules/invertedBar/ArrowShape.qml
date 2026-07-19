import QtQuick
import QtQuick.Shapes
import QtQuick.Effects
import "../../.."

Item{
    id: root
    width: parent.width
    height: parent.height

    property url imageSource: ""
    property real imageOpacity: 1.0
    property int slideDirection: 1

    property color boxColor: Theme.arrowshapeCol
    property int arrowDepth: 12 

    property int border: 1
    property color borderColor: Theme.arrowborderCol

    property bool borderTop: false 
    property bool borderBottom: false
    property bool borderLeft: false
    property bool borderRight: false

    property int arrowLeft: -1 
    property int arrowRight: 1 

    default property alias innerContent: container.data

    Item{
        id: imgContainer
        anchors.fill: parent
        visible: false

        Image{
            id: bgImg
            width: parent.width + 120
            height: parent.height
            x: -60 
            source: root.imageSource
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            sourceSize.height: 300
            onStatusChanged : {
                if(status === Image.Loading){
                    bgImg.opacity = 0
                } 
                else if(status === Image.Ready && source.toString() !== ""){
                    slideAnim.restart()
                }
            }

            ParallelAnimation{
                id: slideAnim
                NumberAnimation{
                    target: bgImg; property: "opacity"
                    from: 0.433; to: 1.0; duration: 100
                }
                NumberAnimation{ 
                    target: bgImg; property: "x"
                    from: -60 + (root.slideDirection * 60)
                    to: -60
                    duration: 400
                    easing.type: Easing.OutQuart 
                }
            }
        }
    }

    Shape {
        id: maskPolygon
        anchors.fill: parent
        visible: false 
        antialiasing: true
        layer.enabled: true
        layer.samples: 4
        preferredRendererType: Shape.CurveRenderer

        ShapePath{
            fillColor: "black" 
            strokeWidth: 0
            startX: root.arrowLeft === 1 ? root.arrowDepth : 0; startY: 0
            PathLine { x: root.width - (root.arrowRight === 1 ? root.arrowDepth : 0); y: 0 }
            PathLine { x: root.width - (root.arrowRight === -1 ? root.arrowDepth : 0); y: root.height / 2 }
            PathLine { x: root.width - (root.arrowRight === 1 ? root.arrowDepth : 0); y: root.height }
            PathLine { x: root.arrowLeft === 1 ? root.arrowDepth : 0; y: root.height }
            PathLine { x: root.arrowLeft === -1 ? root.arrowDepth : 0; y: root.height / 2 }
            PathLine { x: root.arrowLeft === 1 ? root.arrowDepth : 0; y: 0 }
        }
    }

    MultiEffect{
        anchors.fill: parent
        source: imgContainer
        maskEnabled: true
        maskSource: maskPolygon
        visible: root.imageSource.toString() !== ""
        opacity: root.imageOpacity
    }

    Shape{
        anchors.fill: parent
        antialiasing: true
        layer.enabled: true
        layer.samples: 4
        preferredRendererType: Shape.CurveRenderer

        ShapePath{
            fillColor: root.imageSource.toString() !== "" ? "transparent" : root.boxColor
            strokeWidth: 0
            strokeColor: "transparent"
            startX: root.arrowLeft === 1 ? root.arrowDepth : 0; startY: 0
            PathLine { x: root.width - (root.arrowRight === 1 ? root.arrowDepth : 0); y: 0 }
            PathLine { x: root.width - (root.arrowRight === -1 ? root.arrowDepth : 0); y: root.height / 2 }
            PathLine { x: root.width - (root.arrowRight === 1 ? root.arrowDepth : 0); y: root.height }
            PathLine { x: root.arrowLeft === 1 ? root.arrowDepth : 0; y: root.height }
            PathLine { x: root.arrowLeft === -1 ? root.arrowDepth : 0; y: root.height / 2 }
            PathLine { x: root.arrowLeft === 1 ? root.arrowDepth : 0; y: 0 }
        }

        ShapePath{
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderTop ? root.borderColor : "transparent"
            startX: root.arrowLeft === 1 ? root.arrowDepth : 0; startY: 0
            PathLine { x: root.width - (root.arrowRight === 1 ? root.arrowDepth : 0); y: 0 }
        }

        ShapePath{
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderRight ? root.borderColor : "transparent"
            joinStyle: ShapePath.RoundJoin
            startX: root.width - (root.arrowRight === 1 ? root.arrowDepth : 0); startY: 0
            PathLine { x: root.width - (root.arrowRight === -1 ? root.arrowDepth : 0); y: root.height / 2 }
            PathLine { x: root.width - (root.arrowRight === 1 ? root.arrowDepth : 0); y: root.height }
        }

        ShapePath{
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderBottom ? root.borderColor : "transparent"
            startX: root.width - (root.arrowRight === 1 ? root.arrowDepth : 0); startY: root.height
            PathLine { x: root.arrowLeft === 1 ? root.arrowDepth : 0; y: root.height }
        }

        ShapePath{
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderLeft ? root.borderColor : "transparent"
            joinStyle: ShapePath.RoundJoin
            startX: root.arrowLeft === 1 ? root.arrowDepth : 0; startY: root.height
            PathLine { x: root.arrowLeft === -1 ? root.arrowDepth : 0; y: root.height / 2 }
            PathLine { x: root.arrowLeft === 1 ? root.arrowDepth : 0; y: 0 }
        }
    }

    Item{
        id: container
        anchors.fill: parent
        anchors.leftMargin: (root.arrowLeft !== 0 ? root.arrowDepth : 0) + 5
        anchors.rightMargin: (root.arrowRight !== 0 ? root.arrowDepth : 0) + 5
    }
}