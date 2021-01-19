//
//  VenueDetailsViewModel.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation

struct VenueDetailsViewModel {
	let name: String
	let photoURL: URL?
	let rating: Int?
	let ratingColor: String?
	let likesCount: Int
	let city: String
	let postalCode: String?
	let address: String?
}
