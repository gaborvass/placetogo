//
//  RemoteDataProvider.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation

final class RemoteDataProvider: DataProvider {

	func fetch(_ from: URL, then handler: @escaping (Result<Data, FourSquareSDKError>) -> Void) {
		print(from.absoluteString)
		let task = URLSession.shared.dataTask(with: from) { (data, response, _) in
			guard let rawResult = data,
				  let httpResponse = response as? HTTPURLResponse else {
				return handler(.failure(.networkError))
			}
			if httpResponse.statusCode != 200 {
				print("error received: \(httpResponse.statusCode)")
				return handler(.failure(.errorReceived))
			}
			handler(.success(rawResult))
		}
		task.resume()
	}

}
