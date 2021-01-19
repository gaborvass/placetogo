//
//  Executor.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation

struct Executors {
	
	fileprivate let queue: DispatchQueue = DispatchQueue(label: "FoursquareWrapperQueue")

	func bg(_ function: @escaping () -> Void) {
		self.queue.async {
			function()
		}
	}

	func ui(_ function: @escaping () -> Void) {
		DispatchQueue.main.async {
			function()
		}
	}
}
