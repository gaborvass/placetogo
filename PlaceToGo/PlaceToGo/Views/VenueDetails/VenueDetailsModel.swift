//
//  VenueDetailsViewModel.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import FourSquareAPI

class VenueDetailsModel {

	var onDetailsLoaded: ((VenueDetailsViewModel) -> Void)?
	var onError: ((Error) -> Void)?

	func loadDetails(_ id: String) {
		FourSquareSDK.venueDetails(id, success: { venueDetails in
			self.onDetailsLoaded?(self.generateViewModel(venueDetails))
		}, failure: { error in
			self.onError?(error)
		})
	}

	fileprivate func generateViewModel(_ details: VenueDetails) -> VenueDetailsViewModel {
		let name = details.name
		let rating = details.rating != nil ? Int(details.rating!) : nil
		let ratingColor = details.ratingColor ?? nil
		let likesCount = details.likes.likesCount
		var venuePhotoURL: URL?
		if let photoURL = self.generatePhotoURL(details.photos.first) {
			venuePhotoURL = photoURL
		}
		let postalCode = details.address.postalCode
		let address = details.address.address
		let city = details.address.city
		return VenueDetailsViewModel(name: name,
									 photoURL: venuePhotoURL,
									 rating: rating,
									 ratingColor: ratingColor,
									 likesCount: likesCount,
									 city: city,
									 postalCode: postalCode,
									 address: address)
	}

	fileprivate func generatePhotoURL(_ from: VenuePhoto?) -> URL? {
		guard let photo = from else {
			return nil
		}
		return URL(string: photo.prefix + "320x240" + photo.suffix)
	}

}
