//
//  AppDelegate.swift
//  AWSmacOSSDKBuilder
//
//  Created by Wayne on 2/17/18.
//  Copyright © 2018 Amazon Web Services. All rights reserved.
//

import Cocoa
import AWSCore

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {



	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application
		AWSDDLog.add(AWSDDTTYLogger.sharedInstance)
		AWSDDLog.sharedInstance.logLevel = .all
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}


}

