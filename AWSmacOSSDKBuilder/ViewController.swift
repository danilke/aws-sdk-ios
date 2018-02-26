//
//  ViewController.swift
//  AWSmacOSSDKBuilder
//
//  Created by Wayne on 2/17/18.
//  Copyright © 2018 Amazon Web Services. All rights reserved.
//

import Cocoa
import AWSS3
import AWSTranscribe

class ViewController: NSViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	override func viewDidAppear() {
		super.viewDidAppear()
	}
	
	override var representedObject: Any? {
		didSet {
		// Update the view, if already loaded.
		}
	}

	@IBAction func signInTapped(_ sender: Any) {
	}

	@IBAction func startJobCllicked(_ sender: Any) {
		startJob()
	}

	@IBAction func buttonClicked(_ sender: Any) {
		listJobs()
	}

	@IBAction func uploadClicked(_ sender: Any) {
		uploadData()
	}
	@IBAction func getJobClicked(_ sender: Any) {
		getJob(jobName: "Syzygy0001")
	}

	func startJob() {
		AWSTranscribe.default().startTranscriptionJob("Syzygy0003",
													  languageCode: .en_US,
													  mediaUri: "https://s3.amazonaws.com/sytrans-userfiles-mobilehub-1445786753/public/18020706.MP3",
													  mediaFormat: .MP3,
													  mediaSampleRate: nil) { (results, error) in
			if let error = error {
				print("SyTrans: error=\(error)")
			}

			if let results = results {
				print("results=\(results)")
			}
		}
	}

	func listJobs() {
		AWSTranscribe.default().listTranscriptionJobs(.completed) { (results, error) in
			if let error = error {
				print("SyTrans: error=\(error)")
			}

			if let results = results {
				print("results=\(results)")
			}
		}
	}

	func getJob(jobName: String) {
		AWSTranscribe.default().getTranscriptionJob(jobName) { (results, error) in
			if let error = error {
				print("SyTrans: error=\(error)")
			}

			if let results = results {
				print("results=\(results)")
			}
		}
	}

	func uploadData() {

		let data: Data = Data() // Data to be uploaded

		let expression = AWSS3TransferUtilityUploadExpression()
		expression.progressBlock = {(task, progress) in
			DispatchQueue.main.async(execute: {
				print("progress=\(progress))")
			})
		}

		var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
		completionHandler = { (task, error) -> Void in
			DispatchQueue.main.async(execute: {
				// Do something e.g. Alert a user for transfer completion.
				// On failed uploads, `error` contains the error object.
			})
		}

		let transferUtility = AWSS3TransferUtility.default()

		transferUtility.uploadData(data,
								   bucket: "sytrans-userfiles-mobilehub-1445786753",
								   key: "uploads/file.mp3",
								   contentType: "text/plain",
								   expression: expression,
								   completionHandler: completionHandler).continueWith {
									(task) -> AnyObject! in
									if let error = task.error {
										print("Error: \(error.localizedDescription)")
									}

									if let result = task.result {
										print("result=\(result)")
									}
									return nil;
		}
	}
}
