//
//  VenueViewModel.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation

struct VenueViewModel {
	let id: String
	let name: String
	let latitude: Double
	let longitude: Double
	let iconURL: URL?
}

// MARK: Extension: decodable
extension VenueViewModel: Hashable {}
