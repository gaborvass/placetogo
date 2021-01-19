//
//  Venue.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation

public struct Venue {
	public let id: String
	public let name: String
	public let location: VenueLocation
	public let categories: [VenueCategory]
}

// MARK: Extension: decodable
extension Venue: Decodable {}

