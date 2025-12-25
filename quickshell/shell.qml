//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QSG_RENDER_LOOP=threaded
//@ pragma Env QT_QUICK_FLICKABLE_WHEEL_DECELERATION=10000

import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import "services" as QsServices
import "modules/osd"

ShellRoot {
    id: root
    
    // Initialize services immediately
    readonly property var notifs: QsServices.Notifs
    readonly property var pywal: QsServices.Pywal
    readonly property var audio: QsServices.Audio
    readonly property var brightness: QsServices.Brightness
    
    // Direct NotificationServer to ensure it starts

    

    
    Loader {
        id: ccLoader
        source: "modules/controlcenter/ControlCenterWindow.qml"
      }



  


    Component.onCompleted: {
      console.log("QuickShell loaded successfully!")
      controlCenter.shouldShow = true
    }
}
