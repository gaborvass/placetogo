//
//  LocalDataProvider.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation
@testable import FourSquareAPI

// provides data from json files
class LocalDataProvider: DataProvider {

	func fetch(_ from: URL, then handler: @escaping (Result<Data, FourSquareSDKError>) -> Void) {
		handler(.success(self.read(from.lastPathComponent)))
	}

	private func read(_ file: String) -> Data {
		let bundle = Bundle(for: LocalDataProvider.self)
		guard let path = bundle.path(forResource: file, ofType: "json") else {
			fatalError("incorrect bundle")
		}
		print(path)
		guard let data = try? Data(contentsOf: URL.init(fileURLWithPath: path)) else {
			fatalError("incorrect bundle")
		}
		return data
	}
}
