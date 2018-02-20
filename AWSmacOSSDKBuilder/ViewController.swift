//
//  ViewController.swift
//  AWSmacOSSDKBuilder
//
//  Created by Wayne on 2/17/18.
//  Copyright © 2018 Amazon Web Services. All rights reserved.
//

import Cocoa
import AWSTranscribe

class ViewController: NSViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	override func viewDidAppear() {
		super.viewDidAppear()
		listJobs()
	}
	
	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

	func listJobs() {
		AWSTranscribe.default().listTranscriptionJobs(.completed) { (results, error) in
			if let error = error {
				print("error=\(error)")
			}

			if let results = results {
				print("results=\(results)")
			}
		}
	}

}

