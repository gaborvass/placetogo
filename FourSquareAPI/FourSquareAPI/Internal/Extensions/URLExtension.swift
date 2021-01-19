//
//  URLExtension.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation

extension URL {
	func appendingQueryParameters(_ parameters: [String: String?]) -> URL? {
		guard var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
			return nil
		}
		urlComponents.queryItems = (urlComponents.queryItems ?? []) + parameters
			.map { URLQueryItem(name: $0, value: $1) }
		return urlComponents.url
	}
}
