pragma Singleton
import QtQuick

QtObject{

    //Bar
    property color barBg:'#1B1311'
    property color barBorder:'#000000'


    //Animated popup
    property color popupCol: '#000000'





   //Arrowshape
    property color arrowborderCol:'#000000'
    property color arrowshapeCol:'#5f0c06'
    





    //Battery
    property int batwidth: 120        //removed
    property int batheight: 30        //removed
    property int batspacing: 5        //removed
    property int batimgwidth: 21      //removed
    property int batimgheight: 21     //removed
    property string batfontfamily: ""
    property color battextCol: '#ffffff'
    property string batFont: fontFamily
    property int batfontsize: 14





    //Bluetooth
    property int btwidth: 50           //removed
    property int btheight: 30          //removed
    property int btimgwidth: 20        //removed
    property int btimgheight: 20       //removed
    //Bluetooth Popup
    property int btpopupwidth: 250     //removed
    property int btpopupheight: 220    //removed
    property int btmenugap: -2         //removed
    property url btpopupbackground:  Qt.resolvedUrl("/home/origin/Downloads/p6.jpg")
    property bool btblurEnabled: true
    property double btblur: 0.6
    property double btblurmax: 10
    property double btcontrast: 0.5
    property double btsaturation: 0.7
    property double btimageopacity: 0.5
    property double btbrightness: 0.1
    property double btcolorization: 0.46
    property color btcolorizationCol: '#450d03'
    property string btFont: fontFamily
    property int btfontsize: 14





    //Clock
    property color clocktextCol: '#fdfdfd'
    property int clockfontsize: 14
    property string clkFont: fontFamily





    //CPU
    property int cpuwidth: 120           //removed
    property int cpuheight: 30           //removed
    property int cpuspacing: 12          //removed
    property color cpuUsagetextCol: '#ffffff' //Usage
    property int cpuUsagefontsize: 14
    property color cpuTemptextcol: '#ffffff' //Temperature
    property int cpuTempfontsize: 14
    property string cpuFont: fontFamily





    //InternetConns
    property int intwidth: 50            //removed
    property int intheight: 30           //removed
    property int intimgwidth: 20         //removed
    property int intimgheight: 20        //removed
    //InternetConns Popup
    property int intpopupwidth: 500      //removed
    property int intpopupheight: 300     //removed
    property int intmenugap: -2          //removed
    property url intpopupbackground: Qt.resolvedUrl("/home/origin/Downloads/kurisu.jpg")
    property bool intblurEnabled: true
    property double intblur: 0.6
    property double intblurmax: 10
    property double intcontrast: 0.5
    property double intsaturation: 0.7
    property double intimageopacity: 0.5
    property double intbrightness: 0.3
    property double intcolorization: 0.46
    property color intcolorizationCol: '#5e2e0e'
    property string intFont: fontFamily
    




    //Mpris
    property color mprisfontCol: '#fefefe'
    property string mprisFont: fontFamily
    property int mprisFontsize: 16



    

    //PulseWire
    property int pulsespacing: 10       //removed
    //Volume
    property int pulseVolfontsize: 14
    property color pulseVolfontCol: '#ffffff'
    property string pulseFont: fontFamily
    //Volume Db
    property int pulseDBfontsize: 14
    property color pulseDBfontCol: '#ffffff'
    property string pulseDBFont: fontFamily






    //Tray
    property int trayiconSpacing: 12     //removed
    property int trayiconHeight: 18      //removed
    property int trayiconWidth: 18       //removed
    //Tray Popup
    property color traypopuptextCol: '#a6adc8'
    property int traymenugap: -8         //removed
    property url traypopupbackground: Qt.resolvedUrl("/home/origin/Downloads/kurisu.jpg")
    property bool trayblurEnabled: true
    property double trayblur: 0.6
    property double trayblurmax: 8
    property double traycontrast: 0.666
    property double traysaturation: 0.13
    property double trayimageopacity: 0.6
    property double traybrightness: 0.0
    property double traycolorization: 0.4
    property color traycolorizationCol: '#5e2e0e'
    property string trayFont: fontFamily
    property int trayFontSize: 16
    //Tray ChildPopup
    property color trayCpopuptextCol: '#a6adc8'
    property int trayCmenugap: -12        //removed
    property url trayCpopupbackground: Qt.resolvedUrl("/home/origin/Downloads/kurisu.jpg")
    property bool trayCblurEnabled: true
    property double trayCblur: 0.6
    property double trayCblurmax: 8
    property double trayCcontrast: 0.666
    property double trayCsaturation: 0.13
    property double trayCimageopacity: 0.6
    property double trayCbrightness: 0.0
    property double trayCcolorization: 0.4
    property color trayCcolorizationCol: '#5e2e0e'
    property string trayCFont: fontFamily
    property int trayCFontSize: 16




    //WorkSpaces
    property int workspaceSpacing: 12  //removed




    //FONT STYLE COZ YUP(NO WORK HAS BEEN DONE ON THIS)
    property color fontCol: '#ffffff'
    property string fontFamily: "Iosevka Nerd Font"
    property int fontSize: 14
}