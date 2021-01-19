//
//  VenueDetails.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation

public struct VenueDetails {
	public let name: String
	public let rating: Double?
	public let ratingColor: String?
	public let likes: VenueLikes
	public let photos: [VenuePhoto]
	public let address: VenueAddress
}

// MARK: Extension: decodable
extension VenueDetails: Decodable {}
