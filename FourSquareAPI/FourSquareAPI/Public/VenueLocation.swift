//
//  VenueLocation.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation

public struct VenueLocation {
	public let latitude: Double
	public let longitude: Double
}

// MARK: Extension: decodable
extension VenueLocation: Decodable {
	private enum CodingKeys: String, CodingKey {
		case longitude = "lng"
		case latitude = "lat"
	}
}
