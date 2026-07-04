import Quickshell
import QtQuick
import Quickshell.Services.SystemTray

ArrowShape{
    height: parent.height
    width: if(SystemTray.items.values.filter(x => !["Network", "blueman"].includes(x.title)).length <= 3){
        130
    }else{
        SystemTray.items.values.filter(x => !["Network", "blueman"].includes(x.title)).length * 36
    }
    arrowLeft : 1
    arrowRight : -1

    Behavior on width{
        NumberAnimation{
            duration : 200
            easing.type : Easing.OutExpo
        }
    }

    Row{
        anchors.centerIn : parent
        spacing: 12 
        height : parent.height
        Repeater{
            model : SystemTray.items.values.filter(x => !["Network", "blueman"].includes(x.title))
            delegate: Rectangle{
                anchors.verticalCenter : parent.verticalCenter
                height : 18
                width : 18
                color : "transparent"
                Image{
                    height : parent.height
                    width : parent.width
                    source: modelData.icon
                    antialiasing : true
                    smooth : true
                }

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true 
                    cursorShape: Qt.PointingHandCursor 
                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                    onClicked: {
                        if(mouse.button === Qt.LeftButton){
                            modelData.activate()
                            myPopup.close()
                        }else if (mouse.button === Qt.RightButton){
                            myPopup.toggle()
                        }
                    }
                }

                HoverHandler{
                    id: barHover
                    onHoveredChanged: {
                        if (hovered) {
                            myPopup.open()
                        }
                    }
                }

                Timer{
                    interval: 150
                    running: myPopup.isOpen && !barHover.hovered && !myPopup.isHovered && myPopup.openSubmenuCount === 0
                    onTriggered: myPopup.close()
                }
                AnimatedPopup{
                    id : myPopup
                    anchorItem : parent
                    parentWindow : statusBar
                    popupHeight : mainRoot.children.values.filter(x => !x.isSeparator).length * 35 + 15
                    property int openSubmenuCount: 0
                    menuGap : -8

                    QsMenuOpener{
                        id: mainRoot
                        menu: modelData.menu
                    }

                    property int maxCharCount:{
                        let trigger = mainRoot.children ? mainRoot.children.values.length : 0;
                        if (!mainRoot.children) return 0;

                        let max = 0;
                        let items = mainRoot.children.values.filter(x => !x.isSeparator);
                        
                        for (let i = 0; i < items.length; i++) {
                            if (items[i].text && items[i].text.length > max) {
                                max = items[i].text.length;
                            }
                        }
                        return max;
                    }
                    popupWidth: Math.max(130, Math.min(230, (maxCharCount * 8) + 50))

                    Column{
                        height : parent.height
                        width : parent.width
                        spacing : 5
                        anchors.bottomMargin : 15
                        Repeater{
                            model : mainRoot.children.values.filter(x => !x.isSeparator)
                            Rectangle{
                                id: mainMenuItem
                                height: 30
                                width: parent.width
                                color: "transparent"
                                
                                property bool hasSubmenu: modelData.hasChildren

                                Text{
                                    font.pixelSize: 14
                                    color: "white"
                                    text: modelData.text
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 15
                                    width: parent.width - 30 
                                    horizontalAlignment: Text.AlignLeft
                                    elide: Text.ElideRight
                                    font.bold: true
                                }

                                HoverHandler{
                                    id: itemHover
                                    onHoveredChanged: {
                                        if (hovered && mainMenuItem.hasSubmenu) {
                                            childPopup.open()
                                        }
                                    }
                                }

                                Timer{
                                    interval: 150
                                    running: childPopup.isOpen && !itemHover.hovered && !childPopup.isHovered
                                    onTriggered: childPopup.close()
                                }

                                MouseArea{
                                    anchors.fill: parent
                                    hoverEnabled: true 
                                    cursorShape: Qt.PointingHandCursor 

                                    onClicked:{
                                        if (!mainMenuItem.hasSubmenu) {
                                            modelData.triggered()
                                            myPopup.close()
                                        }
                                    }
                                }

                                AnimatedPopup{
                                    id: childPopup
                                    anchorItem: mainMenuItem
                                    parentWindow: statusBar
                                    menuGap : -12
                                    popupAnchorEdges: Edges.Left | Edges.Top
                                    popupAnchorGravity: Edges.Left | Edges.Bottom
                                    animatesLeft: true

                                    onIsOpenChanged:{
                                        if(isOpen){
                                            myPopup.openSubmenuCount++
                                        }else{
                                            myPopup.openSubmenuCount--
                                        }
                                    }

                                    QsMenuOpener{
                                        id: subMenu
                                        menu: mainMenuItem.hasSubmenu ? modelData : null
                                    }

                                    popupHeight: subMenu.children ? subMenu.children.values.filter(x => !x.isSeparator).length * 35 + 15 : 0

                                    property int maxCharCount:{
                                        if(!subMenu.children) return 0;
                                        let max = 0;
                                        let items = subMenu.children.values.filter(x => !x.isSeparator);
                                        for(let i = 0; i < items.length; i++){
                                            if(items[i].text && items[i].text.length > max){
                                                max = items[i].text.length;
                                            }
                                        }
                                        return max;
                                    }
                                    
                                    popupWidth: Math.max(130, Math.min(200, (maxCharCount * 8) + 50))
                                    
                                    Column{
                                        height: parent.height
                                        width: parent.width
                                        spacing: 5
                                        anchors.bottomMargin: 15

                                        Repeater{
                                            model: subMenu.children ? subMenu.children.values.filter(x => !x.isSeparator) : null
                                            
                                            Rectangle{
                                                height: 30
                                                width: parent.width
                                                color: "transparent"
                                                
                                                Text{
                                                    font.pixelSize: 14
                                                    color: "white"
                                                    text: modelData.text
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    anchors.left: parent.left
                                                    anchors.leftMargin: 15
                                                    width: parent.width - 30 
                                                    horizontalAlignment: Text.AlignLeft
                                                    elide: Text.ElideRight
                                                    font.bold: true
                                                }
                                                
                                                MouseArea{
                                                    anchors.fill: parent
                                                    hoverEnabled: true 
                                                    cursorShape: Qt.PointingHandCursor 
                                                    onClicked:{
                                                        modelData.triggered()
                                                        childPopup.close()
                                                        myPopup.close()
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }   
                            }
                        }
                    }
                }
            }
        }
    }
}

// QsMenuOpener {
                //     id: mainRoot
                //     menu: modelData.menu
                // }

                // QsMenuOpener {
                //     id: subMenu
                //     menu:mainRoot.children.values[2]
                // }

                // Text {
                //     anchors.centerIn: parent
                //     color: "white"
                //     text: subMenu.children.values[0].text
                // }