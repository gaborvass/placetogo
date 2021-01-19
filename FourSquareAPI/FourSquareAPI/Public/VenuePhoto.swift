//
//  VenuePhoto.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation

public struct VenuePhoto {
	public let prefix: String
	public let suffix: String
}

// MARK: Extension: decodable
extension VenuePhoto: Decodable {}
