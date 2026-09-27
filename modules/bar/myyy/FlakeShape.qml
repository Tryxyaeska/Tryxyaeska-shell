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

    property bool borderTop: false
    property bool borderBottom: false
    property bool borderLeft: false
    property bool borderRight: false

    default property alias innerContent: container.data

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

            PathLine { x: root.width; y: 0 }

            PathLine { 
                x: root.width - root.slantOffset + root.cornerRadius
                y: root.height - root.cornerRadius 
            }

            PathQuad { 
                x: root.width - root.slantOffset - root.cornerRadius
                y: root.height
                controlX: root.width - root.slantOffset
                controlY: root.height
            }

            PathLine { 
                x: root.slantOffset + root.cornerRadius
                y: root.height 
            }

            PathQuad { 
                x: root.slantOffset - root.cornerRadius
                y: root.height - root.cornerRadius
                controlX: root.slantOffset
                controlY: root.height
            }

            PathLine { x: 0; y: 0 }
        }

        //L2: TOP BORDER
        ShapePath {
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderTop ? root.borderColor : "transparent"
            capStyle: ShapePath.FlatCap

            startX: 0; startY: 0
            PathLine { x: root.width; y: 0 }
        }

        //L3: RIGHT BORDER + BOTTOMRIGHT CURVE
        ShapePath {
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderRight ? root.borderColor : "transparent"
            capStyle: ShapePath.RoundCap

            startX: root.width; startY: 0
            PathLine { 
                x: root.width - root.slantOffset + root.cornerRadius
                y: root.height - root.cornerRadius 
            }
            PathQuad { 
                x: root.width - root.slantOffset - root.cornerRadius
                y: root.height
                controlX: root.width - root.slantOffset
                controlY: root.height
            }
        }

        //L4: BOTTOM BORDER
        ShapePath {
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderBottom ? root.borderColor : "transparent"
            capStyle: ShapePath.FlatCap

            startX: root.width - root.slantOffset - root.cornerRadius; startY: root.height
            PathLine { 
                x: root.slantOffset + root.cornerRadius
                y: root.height 
            }
        }

        //L5: BOTTOMLEFT CURVE + LEFT BORDER
        ShapePath {
            fillColor: "transparent"
            strokeWidth: root.borderWidth
            strokeColor: root.borderLeft ? root.borderColor : "transparent"
            capStyle: ShapePath.RoundCap

            startX: root.slantOffset + root.cornerRadius; startY: root.height
            PathQuad { 
                x: root.slantOffset - root.cornerRadius
                y: root.height - root.cornerRadius
                controlX: root.slantOffset
                controlY: root.height
            }
            PathLine { x: 0; y: 0 }
        }
    }

    Item {
        id: container
        anchors.fill: parent
        anchors.leftMargin: root.slantOffset + 4
        anchors.rightMargin: root.slantOffset + 4
    }
}