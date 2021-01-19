//
//  Request.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation

enum RequestType {
	case search
	case detail
}

struct Request {

	let type: RequestType

	fileprivate let path: String
	fileprivate let queryItems: [URLQueryItem]

	var url: URL? {
		var urlComponents = URLComponents()
		urlComponents.scheme = "https"
		urlComponents.host = "api.foursquare.com"
		urlComponents.path = self.path
		if !self.queryItems.isEmpty {
			urlComponents.queryItems = self.queryItems
		}
		return urlComponents.url
	}

	static func create(type: RequestType, path: String, queryParams: [String: String] = [:]) -> Self {
		let queryItems = queryParams.map {
			URLQueryItem(name: $0, value: $1)
		}
		return Request(type: type, path: path, queryItems: queryItems)
	}
}

// MARK: Extensions

extension Request {

	static func fromVenuesQuery(_ query: VenuesQuery) -> Self {
		if let coordinate = query.coordinate {
			return .searchLocation(latitude: coordinate.latitude,
								   longitude: coordinate.longitude,
								   radius: query.radius,
								   limit: query.limit,
								   categoryId: query.category
								   )
		}
		if let city = query.city {
			return .searchCity(city: city,
							   radius: query.radius,
							   limit: query.limit,
							   categoryId: query.category)
		}
		// last resort to provide some data
		return .searchCity(city: "Amsterdam, NL",
						   radius: query.radius,
						   limit: query.limit,
						   categoryId: query.category
		)
	}

	static func searchLocation(latitude: Double, longitude: Double, radius: Int, limit: Int, categoryId: String) -> Self {
		return .create(type: .search,
					   path: "/v2/venues/explore",
					   queryParams: [
							"ll": "\(latitude),\(longitude)",
							"radius": "\(radius)",
							"limit": "\(limit)",
							"categoryId": "\(categoryId)",
					   ])
	}

	static func searchCity(city: String, radius: Int, limit: Int, categoryId: String) -> Self {
		return .create(type: .search,
					   path: "/v2/venues/explore",
					   queryParams: [
							"near": city,
							"radius": "\(radius)",
							"limit": "\(limit)",
							"categoryId": "\(categoryId)",
					   ])
	}
}

extension Request {

	static func detail(venueId: String) -> Self {
		return .create(type: .detail, path: "/v2/venues/\(venueId)")
	}

}
