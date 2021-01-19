//
//  RequestParameterProvider.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 16/01/2021.
//

import Foundation

struct RequestParameterProvider {

	fileprivate var clientConfiguration: Configuration

	init(_ componentProvider: ComponentProvider) {
		self.clientConfiguration = componentProvider.provide(Configuration.self)
	}

	lazy var defaultParameters: [String: String?] = {
		return [
			"client_id": clientConfiguration.clientID,
			"client_secret": clientConfiguration.clientSecret,
			"v": clientConfiguration.clientVersion,
		]
	}()
}
