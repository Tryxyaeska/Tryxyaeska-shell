pragma Singleton
import QtQuick
import "Themes"

QtObject {
    
    readonly property QtObject customtheme: DefaultTheme {}

    //Bar
    property color barBg: customtheme.barBg
    property color barBorder: customtheme.barBorder


    //Animated popup
    property color popupCol: customtheme.popupCol


   //Arrowshape
    property color arrowborderCol: customtheme.arrowborderCol
    property color arrowshapeCol: customtheme.arrowshapeCol
    property color invArrowshapeCol: customtheme.invArrowshapeCol


    //FlakeShape & Flake Architecture
    property color flakeShapeCol: customtheme.flakeShapeCol
    property color flakeFontCol: customtheme.flakeFontCol

    property color flakeBg: customtheme.flakeBg
    property color flakeBorderCol: customtheme.flakeBorderCol
    property color flakeAccentCol: customtheme.flakeAccentCol
    property color flakeContainerCol: customtheme.flakeContainerCol
    property color flakeContainerLowCol: customtheme.flakeContainerLowCol

    property color flakePrimaryTextCol: customtheme.flakePrimaryTextCol
    property color flakeSubTextCol: customtheme.flakeSubTextCol
    property color flakeAccentTextCol: customtheme.flakeAccentTextCol
    property color flakeOnAccentTextCol: customtheme.flakeOnAccentTextCol

    property color flakeActiveIndicator: customtheme.flakeActiveIndicator
    property color flakeInactiveIndicator: customtheme.flakeInactiveIndicator
    property color flakeErrorCol: customtheme.flakeErrorCol
    property color flakeHoverCol: customtheme.flakeHoverCol


    //Battery
    property int batwidth: 120        //removed
    property int batheight: 30        //removed
    property int batspacing: 5        //removed
    property int batimgwidth: 21      //removed
    property int batimgheight: 21     //removed
    property color battextCol: customtheme.battextCol
    property string batFont: customtheme.batFont
    property int batfontsize: customtheme.batfontsize


    //Bluetooth
    property int btwidth: 50           //removed
    property int btheight: 30          //removed
    property int btimgwidth: 20        //removed
    property int btimgheight: 20       //removed
    //Bluetooth Popup
    property int btpopupwidth: 250     //removed
    property int btpopupheight: 220    //removed
    property int btmenugap: -2         //removed
    property url btpopupbackground: customtheme.btpopupbackground
    property bool btblurEnabled: customtheme.btblurEnabled
    property double btblur: customtheme.btblur
    property double btblurmax: customtheme.btblurmax
    property double btcontrast: customtheme.btcolorization
    property double btsaturation: customtheme.btsaturation
    property double btimageopacity: customtheme.btimageopacity
    property double btbrightness: customtheme.btbrightness
    property double btcolorization: customtheme.btcolorization
    property color btcolorizationCol: customtheme.btcolorizationCol
    property string btFont: customtheme.btFont
    property int btfontsize: customtheme.btfontSize


    //Clock
    property color clocktextCol: customtheme.clocktextCol
    property int clockfontsize: customtheme.clockFontSize
    property string clkFont: customtheme.clkFont


    //CPU
    property int cpuwidth: 120           //removed
    property int cpuheight: 30           //removed
    property int cpuspacing: 12          //removed
    property color cpuUsagetextCol: customtheme.cpuUsagetextCol //Usage
    property int cpuUsagefontsize: customtheme.cpuUsagefontsize
    property color cpuTemptextcol: customtheme.cpuTemptextcol //Temperature
    property int cpuTempfontsize: customtheme.cpuTempfontsize
    property string cpuFont: customtheme.cpuFont


    //InternetConns
    property int intwidth: 50            //removed
    property int intheight: 30           //removed
    property int intimgwidth: 20         //removed
    property int intimgheight: 20        //removed
    //InternetConns Popup
    property int intpopupwidth: 500      //removed
    property int intpopupheight: 300     //removed
    property int intmenugap: -2          //removed
    property url intpopupbackground: customtheme.intpopupbackground
    property bool intblurEnabled: customtheme.intblurEnabled
    property double intblur: customtheme.intblur
    property double intblurmax: customtheme.intblurmax
    property double intcontrast: customtheme.intcontrast
    property double intsaturation: customtheme.intsaturation
    property double intimageopacity: customtheme.intimageopacity
    property double intbrightness: customtheme.intbrightness
    property double intcolorization: customtheme.intcolorization
    property color intcolorizationCol: customtheme.intcolorizationCol
    property string intFont: customtheme.intFont


    //Mpris
    property color mprisfontCol: customtheme.mprisfontCol
    property string mprisFont: customtheme.mprisFont
    property int mprisFontsize: customtheme.mprisFontsize


    //PulseWire
    property int pulsespacing: 10       //removed
    //Volume
    property int pulseVolfontsize: customtheme.pulseVolfontsize
    property color pulseVolfontCol: customtheme.pulseVolfontCol
    property string pulseFont: customtheme.pulseFont
    //Volume Db
    property int pulseDBfontsize: customtheme.pulseDBfontsize
    property color pulseDBfontCol: customtheme.pulseDBfontCol
    property string pulseDBFont: customtheme.pulseDBFont


    //Tray
    property int trayiconSpacing: 12     //removed
    property int trayiconHeight: 18      //removed
    property int trayiconWidth: 18       //removed
    //Tray Popup
    property color traypopuptextCol: customtheme.traypopuptextCol
    property int traymenugap: -8         //removed
    property url traypopupbackground: customtheme.traypopupbackground
    property bool trayblurEnabled: customtheme.trayblurEnabled
    property double trayblur: customtheme.trayblur
    property double trayblurmax: customtheme.trayblurmax
    property double traycontrast: customtheme.traycontrast
    property double traysaturation: customtheme.trayCsaturation
    property double trayimageopacity: customtheme.trayimageopacity
    property double traybrightness: customtheme.traybrightness
    property double traycolorization: customtheme.traycolorization
    property color traycolorizationCol: customtheme.traycolorizationCol
    property string trayFont: customtheme.trayFont
    property int trayFontSize: customtheme.trayFontSize
    //Tray ChildPopup
    property color trayCpopuptextCol: customtheme.trayCpopuptextCol
    property int trayCmenugap: -12        //removed
    property url trayCpopupbackground: customtheme.trayCpopupbackground
    property bool trayCblurEnabled: customtheme.trayCblurEnabled
    property double trayCblur: customtheme.trayCblur
    property double trayCblurmax: customtheme.trayCblurmax
    property double trayCcontrast: customtheme.trayCcontrast
    property double trayCsaturation: customtheme.trayCsaturation
    property double trayCimageopacity: customtheme.trayCimageopacity
    property double trayCbrightness: customtheme.trayCbrightness
    property double trayCcolorization: customtheme.trayCcolorization
    property color trayCcolorizationCol: customtheme.trayCcolorizationCol
    property string trayCFont: customtheme.trayCFont
    property int trayCFontSize: customtheme.trayCFontSize


    //WorkSpaces
    property int workspaceSpacing: 12  //removed
    property string workspaceFontFamily: customtheme.workspaceFontFamily


    //Base Typography
    property color fontCol: customtheme.fontCol
    property string fontFamily: customtheme.fontFamily
    property int fontSize: customtheme.fontSize
}