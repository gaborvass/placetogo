//
//  VenueAddress.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation

public struct VenueAddress {
	public let address: String?
	public let postalCode: String?
	public let city: String
}

// MARK: Extension: decodable
extension VenueAddress: Decodable {}
