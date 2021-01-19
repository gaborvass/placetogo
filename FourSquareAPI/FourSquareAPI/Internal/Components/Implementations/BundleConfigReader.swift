//
//  ConfigReader.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation

final class BundleConfigReader: ConfigReader {

	func readString(_ key: ConfigKey) -> String? {
		return Bundle.main.infoDictionary?[key.rawValue] as? String
	}

}
