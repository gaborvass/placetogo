//
//  CoreLocationManager.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import CoreLocation

class CoreLocationManager: NSObject {

	var onLocationAvailable: ((CLLocation?) -> Void)?

	fileprivate var locationManager: CLLocationManager?
	fileprivate var didReceiveLocationPermission = false
	fileprivate var didInvokeLocationAvailable = false

	func start() {
		self.locationManager = CLLocationManager()
		self.locationManager?.delegate = self
		self.locationManager?.requestAlwaysAuthorization()
	}
}

// MARK: Extension: CLLocationManagerDelegate
extension CoreLocationManager: CLLocationManagerDelegate {

	// Default location to use when permission is not granted or using simulator
	fileprivate static let defaultLocation = CLLocation(latitude: 52.37403, longitude: 4.88969)

	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		self.didReceiveLocationPermission = true
		switch status {
			case .authorizedAlways, .authorizedWhenInUse:
				#if targetEnvironment(simulator)
					// return default location to avoid issue when Allow Location Simulation is disabled
					self.onLocationAvailable?(Self.defaultLocation)
				#else
					self.locationManager?.startUpdatingLocation()
				#endif
			case .notDetermined:
				// do nothing, wait until user decided
				return
			default:
				// return with Amsterdam location
				self.onLocationAvailable?(Self.defaultLocation)
		}
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if !self.didInvokeLocationAvailable && self.didReceiveLocationPermission {
			self.didInvokeLocationAvailable = true
			self.onLocationAvailable?(locations.first)
		}
	}
}
