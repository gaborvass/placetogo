//
//  ConfigReader.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 17/01/2021.
//

import Foundation

enum ConfigKey: String {
	case clientID = "FourSquareClientID"
	case clientSecret = "FourSquareClientSecret"
}

protocol ConfigReader {
	func readString(_ key: ConfigKey) -> String?
}
