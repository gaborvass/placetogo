//
//  VenueCategory.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation

public struct VenueCategory {
	public let id: String
	public let name: String
	public let icon: VenueIcon
}

// MARK: Extension: decodable
extension VenueCategory: Decodable {}
