//
//  AppDelegate.swift
//  HgetMoves2
//
//  Created by Hector on 5/20/19.
//  Copyright © 2019 hcarrasco. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.title = "HCGetmoves 2"
        statusItem.button?.target = self
        statusItem.button?.action = #selector(showSettings)
        NSApp.setActivationPolicy(.accessory)
        UserDefaults.standard.setValue(0, forKey: "rating")
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func showSettings() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier:"ViewController") as?
            ViewController else {
                fatalError("Unable to find viewcontroller in the sotoryboard")
        }
        
        guard let button = statusItem.button else {
            fatalError("Unable find")
        }
        
        let popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        popoverView.show (relativeTo: button.bounds, of: button, preferredEdge: .maxY)
    }
    
    func changeAppTitle (title: String) {
        statusItem.button?.title = title
    }

}

