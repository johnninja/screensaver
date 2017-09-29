//
//  AppDelegate.swift
//  ScreenView
//
//  Created by zhw on 2017/9/28.
//  Copyright © 2017年 zhw. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!

    let screenView = CoolScreenSaver(frame: NSZeroRect, isPreview: false)
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let screenView = screenView {
            screenView.frame = (window.contentView?.bounds)!
            window.contentView?.addSubview(screenView)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

