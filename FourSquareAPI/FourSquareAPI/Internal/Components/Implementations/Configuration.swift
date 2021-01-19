//
//  ClientConfiguration.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation

struct Configuration {

	fileprivate let configReader: ConfigReader

	init(_ componentProvider: ComponentProvider) {
		self.configReader = componentProvider.provide(ConfigReader.self)
	}

	lazy var clientID: String? = {
		return self.configReader.readString(.clientID)
	}()

	lazy var clientSecret: String? = {
		return self.configReader.readString(.clientSecret)
	}()

	let clientVersion: String = "20180323"
}
