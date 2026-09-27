import QtQuick
import QtQuick.Shapes
import "../../.."

Item {
    id: root
    width: parent ? parent.width : 200
    height: parent ? parent.height : 50

    property color boxColor: Theme.flakeShapeCol
    property color borderColor: Theme.arrowborderCol
    property int borderWidth: 1

    property real slantOffset: 16
    property real cornerRadius: 8

    property bool slantLeft: true
    property bool slantRight: true

    property bool borderTop: false
    property bool borderBottom: false
    property bool borderLeft: false
    property bool borderRight: false

    default property alias innerContent: container.data

    // Internal computed geometries based on slant flags
    readonly property real effLeftSlant: slantLeft ? slantOffset : 0
    readonly property real effLeftRadius: slantLeft ? cornerRadius : 0

    readonly property real effRightSlant: slantRight ? slantOffset : 0
    readonly property real effRightRadius: slantRight ? cornerRadius : 0

    Behavior on boxColor {
        ColorAnimation {
            duration: 200
            easing.type: Easing.OutQuad
        }
    }

    Shape {
        anchors.fill: parent
        antialiasing: true
        layer.enabled: true
        layer.samples: 4
        preferredRendererType: Shape.CurveRenderer

        // L1: BACKGROUND FILL
        ShapePath {
            fillColor: root.boxColor
            strokeWidth: 0
            strokeColor: "transparent"

            startX: 0; startY: 0

            // Top straight horizontal line
            PathLine { x: root.width; y: 0 }

            // Right side transition (slanted or straight vertical)
            PathLine { 
                x: root.width - root.effRightSlant + root.effRightRadius
                y: root.height - root.effRightRadius 
            }

            // Bottom-right corner (curved if slanted, sharp/straight if false)
            PathQuad { 
                x: root.width - root.effRightSlant - root.effRightRadius
                y: root.height
                controlX: root.width - root.effRightSlant
                controlY: root.height
            }

            // Bottom edge
            PathLine { 
                x: root.effLeftSlant + root.effLeftRadius
                y: root.height 
            }

            // Bottom-left corner (curved if slanted, sharp/straight if false)
            PathQuad { 
                x: root.effLeftSlant - root.effLeftRadius
                y: root.height - root.effLeftRadius
                controlX: root.effLeftSlant
                controlY: root.height
            }

            // Left side back to top-left
            PathLine { x: 0; y: 0 }
        }

        // L2: TOP BORDER
        ShapePath {
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderTop ? root.borderColor : "transparent"
            capStyle: ShapePath.FlatCap

            startX: 0; startY: 0
            PathLine { x: root.width; y: 0 }
        }

        // L3: RIGHT BORDER + BOTTOM-RIGHT CORNER
        ShapePath {
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderRight ? root.borderColor : "transparent"
            capStyle: root.slantRight ? ShapePath.RoundCap : ShapePath.FlatCap

            startX: root.width; startY: 0
            PathLine { 
                x: root.width - root.effRightSlant + root.effRightRadius
                y: root.height - root.effRightRadius 
            }
            PathQuad { 
                x: root.width - root.effRightSlant - root.effRightRadius
                y: root.height
                controlX: root.width - root.effRightSlant
                controlY: root.height
            }
        }

        // L4: BOTTOM BORDER
        ShapePath {
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderBottom ? root.borderColor : "transparent"
            capStyle: ShapePath.FlatCap

            startX: root.width - root.effRightSlant - root.effRightRadius
            startY: root.height
            PathLine { 
                x: root.effLeftSlant + root.effLeftRadius
                y: root.height 
            }
        }

        // L5: BOTTOM-LEFT CORNER + LEFT BORDER
        ShapePath {
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderLeft ? root.borderColor : "transparent"
            capStyle: root.slantLeft ? ShapePath.RoundCap : ShapePath.FlatCap

            startX: root.effLeftSlant + root.effLeftRadius
            startY: root.height
            PathQuad { 
                x: root.effLeftSlant - root.effLeftRadius
                y: root.height - root.effLeftRadius
                controlX: root.effLeftSlant
                controlY: root.height
            }
            PathLine { x: 0; y: 0 }
        }
    }

    Item {
        id: container
        anchors.fill: parent
        anchors.leftMargin: root.effLeftSlant + 4
        anchors.rightMargin: root.effRightSlant + 4
    }
}