//
//  MockConfigReader.swift
//  FourSquareWrapperTests
//
//  Created by Gábor Vass on 16/01/2021.
//

import Foundation
@testable import FourSquareAPI

class MockConfigReader: ConfigReader {
	func readString(_ key: ConfigKey) -> String? {
		switch key {
			case .clientID:
				return "mockClientID"
			case .clientSecret:
				return "mockClientSecret"
		}
	}

	
}
