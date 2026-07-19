import QtQuick
import QtQuick.Shapes

Shape {
    id: upArrow

    implicitWidth: 50
    implicitHeight: 10

    property color arrowColor: "#cba6f7" 

    layer.enabled: true 
    layer.samples: 4

    ShapePath {
        fillColor: upArrow.arrowColor
        strokeColor: "transparent"
        strokeWidth: 0

        startX: 0
        startY: upArrow.height

        PathLine { 
            x: upArrow.width / 2 
            y: 0 
        }

        PathLine { 
            x: upArrow.width 
            y: upArrow.height 
        }

        PathLine { 
            x: 0 
            y: upArrow.height 
        }
    }
}