//
//  MapViewModel.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//
import Foundation
import MapKit
import FourSquareAPI

class MapModel {

	let locationManager = CoreLocationManager()
	var onDataLoaded: ((CLLocation?, Set<VenueViewModel>) -> Void)?
    var onError: ((Error) -> Void)?

	fileprivate var venueViewModels: Set<VenueViewModel> = []
	fileprivate var query: VenuesQuery?
	fileprivate var userLocation: CLLocation?

	init() {
		self.locationManager.onLocationAvailable = { location in
			self.userLocation = location

			if let location = location {
				self.query = VenuesQuery.create(location.coordinate)
			} else {
				self.query = VenuesQuery.create("Amsterdam, NL")
			}
			self.load()
		}
		self.locationManager.start()
	}

	func updateRange(_ newRange: Int) {
		self.query?.radius = newRange
		self.load()
	}

	func load() {
		if let venuesQuery = self.query {
			FourSquareSDK.searchVenues(query: venuesQuery) { venues in
				let newModels = self.generateViewModel(from: venues)
				self.mergeResult(newModels)
				self.onDataLoaded?(self.userLocation, self.venueViewModels)
			} failure: { error in
				self.onError?(error)
			}
		}
    }

	fileprivate func mergeResult(_ newEntries: [VenueViewModel]) {
		self.venueViewModels = self.venueViewModels.filter {
			newEntries.contains($0)
		}
		newEntries.forEach {
			self.venueViewModels.insert($0)
		}
	}

	fileprivate func generateViewModel(from: [Venue]) -> [VenueViewModel] {
		return from.map {
			let id = $0.id
			let name = $0.name
			let url = self.generateIconURL(from: $0.categories.first?.icon)
			let longitude = $0.location.longitude
			let latitude = $0.location.latitude
			return VenueViewModel(id: id, name: name, latitude: latitude, longitude: longitude, iconURL: url)
		}
	}

	fileprivate func generateIconURL(from: VenueIcon?) -> URL? {
		guard let venueIcon = from else {
			return nil
		}
		return URL(string: venueIcon.prefix + "bg_32" + venueIcon.suffix)
	}
}
