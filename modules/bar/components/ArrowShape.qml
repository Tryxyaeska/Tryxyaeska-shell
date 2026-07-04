import QtQuick
import QtQuick.Shapes

Item {
    id: root
    width: parent.width
    height: parent.height

    property color boxColor: "#5151a5"
    property int arrowDepth: 12 

    property int border: 1
    property color borderColor: "#FFFFFF"

    property bool borderTop: false
    property bool borderBottom: false
    property bool borderLeft: false
    property bool borderRight: false

    property int arrowLeft: -1  
    property int arrowRight: 1  

    default property alias innerContent: container.data

    Shape {
        anchors.fill: parent
        antialiasing: true
        layer.enabled: true
        layer.samples: 4
        preferredRendererType: Shape.CurveRenderer

        //L1, THE BACKGROUND FILL, NO BORDER
        ShapePath {
            fillColor: root.boxColor
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

        //L2 - TOP BORDER
        ShapePath {
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderTop ? root.borderColor : "transparent"
            
            startX: root.arrowLeft === 1 ? root.arrowDepth : 0; startY: 0
            PathLine { x: root.width - (root.arrowRight === 1 ? root.arrowDepth : 0); y: 0 }
        }

        //L3, RIGHT BORDER
        ShapePath {
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderRight ? root.borderColor : "transparent"
            joinStyle: ShapePath.RoundJoin

            startX: root.width - (root.arrowRight === 1 ? root.arrowDepth : 0); startY: 0
            PathLine { x: root.width - (root.arrowRight === -1 ? root.arrowDepth : 0); y: root.height / 2 }
            PathLine { x: root.width - (root.arrowRight === 1 ? root.arrowDepth : 0); y: root.height }
        }

        //L4: BOTTOM BORDER
        ShapePath {
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderBottom ? root.borderColor : "transparent"

            startX: root.width - (root.arrowRight === 1 ? root.arrowDepth : 0); startY: root.height
            PathLine { x: root.arrowLeft === 1 ? root.arrowDepth : 0; y: root.height }
        }

        //L5 - LEFT BORDER
        ShapePath {
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderLeft ? root.borderColor : "transparent"
            joinStyle: ShapePath.RoundJoin

            startX: root.arrowLeft === 1 ? root.arrowDepth : 0; startY: root.height
            PathLine { x: root.arrowLeft === -1 ? root.arrowDepth : 0; y: root.height / 2 }
            PathLine { x: root.arrowLeft === 1 ? root.arrowDepth : 0; y: 0 }
        }
    }

    Item {
        id: container
        anchors.fill: parent
        anchors.leftMargin: (root.arrowLeft !== 0 ? root.arrowDepth : 0) + 5
        anchors.rightMargin: (root.arrowRight !== 0 ? root.arrowDepth : 0) + 5
    }
}