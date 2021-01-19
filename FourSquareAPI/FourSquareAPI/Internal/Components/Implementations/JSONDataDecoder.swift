//
//  JSONDataDecoder.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 16/01/2021.
//

import Foundation

struct JSONDataDecoder: DataDecoder {

	func decode<T>(_ data: Data, of type: RequestType) -> Result<T, FourSquareSDKError> {
		do {
			var result: Any
			switch type {
				case .search:
					result = try decodeSearchResult(data)
				case .detail:
					result = try decodeDetailResult(data)
			}
			if let result = result as? T {
				return .success(result)
			}
			return .failure(.parserError)
		} catch {
			return .failure(.parserError)
		}
	}

}

// MARK: Extension: decode search result
extension JSONDataDecoder {

	func decodeSearchResult(_ data: Data) throws -> [Venue] {
		guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any> else {
			throw FourSquareSDKError.parserError
		}
		try validateResponse(jsonDictionary)
		guard let response = jsonDictionary["response"] as? Dictionary<String, Any> else {
			throw FourSquareSDKError.parserError
		}
		guard let groups = response["groups"] as? Array<Dictionary<String, Any>> else {
			throw FourSquareSDKError.parserError
		}
		var venues: [Venue] = []
		try? groups.forEach { group in
			guard let items = group["items"] as? Array<Dictionary<String, Any>> else {
				throw FourSquareSDKError.parserError
			}
			try? items.forEach { item in
				guard let venueJSON = item["venue"]  as? Dictionary<String, Any> else {
					throw FourSquareSDKError.parserError
				}
				let venue = try decodeVenue(JSONSerialization.data(withJSONObject: venueJSON, options: .fragmentsAllowed))
				venues.append(venue)
			}
		}
		return venues
	}

}

// MARK: Extension: decode venue details
extension JSONDataDecoder {

	func decodeDetailResult(_ data: Data) throws -> VenueDetails {
		guard let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any> else {
			throw FourSquareSDKError.parserError
		}
		try validateResponse(jsonDictionary)
		guard let response = jsonDictionary["response"] as? Dictionary<String, Any> else {
			throw FourSquareSDKError.parserError
		}
		guard let venueJSON = response["venue"] as? Dictionary<String, Any> else {
			throw FourSquareSDKError.parserError
		}
		let rating = venueJSON["rating"] as? Double
		let ratingColor = venueJSON["ratingColor"] as? String
		guard let name = venueJSON["name"] as? String else {
			throw FourSquareSDKError.parserError
		}
		guard let likesJSON = venueJSON["likes"] as? Dictionary<String, Any> else {
			throw FourSquareSDKError.parserError
		}
		guard let likesCount = likesJSON["count"] as? Int else {
			throw FourSquareSDKError.parserError
		}
		guard let photosJSON = venueJSON["photos"] as? Dictionary<String, Any> else {
			throw FourSquareSDKError.parserError
		}
		guard let photoGroups = photosJSON["groups"] as? Array<Dictionary<String, Any>> else {
			throw FourSquareSDKError.parserError
		}
		var photos: [VenuePhoto] = []
		try? photoGroups.forEach { group in
			guard let items = group["items"] as? Array<Dictionary<String, Any>> else {
				throw FourSquareSDKError.parserError
			}
			try? items.forEach { item in
				let photo = try decodeVenuePhoto(JSONSerialization.data(withJSONObject: item, options: .fragmentsAllowed))
				photos.append(photo)
			}
		}
		let venueLikes = VenueLikes(likesCount: likesCount)
		guard let locationJSON = venueJSON["location"] as? Dictionary<String, Any> else {
			throw FourSquareSDKError.parserError
		}
		let address = try self.decodeVenueAddress(JSONSerialization.data(withJSONObject: locationJSON, options: .fragmentsAllowed))
		return VenueDetails(name: name, rating: rating, ratingColor: ratingColor, likes: venueLikes, photos: photos, address: address)
	}

}

// MARK: Extension: decode single venue
extension JSONDataDecoder {

	func decodeVenue(_ data: Data) throws -> Venue {
		guard let venue = try? JSONDecoder().decode(Venue.self, from: data) else {
			throw FourSquareSDKError.parserError
		}
		return venue
	}

}

// MARK: Extension: check if response is valid
extension JSONDataDecoder {
	func validateResponse(_ responseObject: Dictionary<String, Any>) throws {
		guard let metaJSON = responseObject["meta"] as? Dictionary<String, Any> else {
			throw FourSquareSDKError.parserError
		}
		guard let responseCode = metaJSON["code"] as? Int else {
			throw FourSquareSDKError.parserError
		}
		if responseCode != 200 {
			print("error code received: \(responseCode)")
			throw FourSquareSDKError.errorReceived
		}
	}
}

// MARK: Extension: decode venue likes
extension JSONDataDecoder {

	func decodeVenueLikes(_ data: Data) throws -> VenueLikes {
		guard let venueLikes = try? JSONDecoder().decode(VenueLikes.self, from: data) else {
			throw FourSquareSDKError.parserError
		}
		return venueLikes
	}

}

// MARK: Extension: decode venue photo
extension JSONDataDecoder {

	func decodeVenuePhoto(_ data: Data) throws -> VenuePhoto {
		guard let photo = try? JSONDecoder().decode(VenuePhoto.self, from: data) else {
			throw FourSquareSDKError.parserError
		}
		return photo
	}
	
}

// MARK: Extension: decode venue photo
extension JSONDataDecoder {

	func decodeVenueAddress(_ data: Data) throws -> VenueAddress {
		guard let address = try? JSONDecoder().decode(VenueAddress.self, from: data) else {
			throw FourSquareSDKError.parserError
		}
		return address
	}

}

