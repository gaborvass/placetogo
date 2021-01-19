//
//  VenuesQuery.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import CoreLocation

public struct VenuesQuery {
	// default radius in meters
	public static let defaultRadius = 1000
	// default radius in meters
	public static let defaultLimit = 100
	// default category is museums
	public static let defaultCategory = "4bf58dd8d48988d181941735"

	public var radius = defaultRadius
	public var limit = defaultLimit
	public var category = defaultCategory

	internal let city: String?
	internal let coordinate: CLLocationCoordinate2D?

	/**
	Create query to search by location coordinates.
	- parameters:
		- coordinate: CLLocationCoordinate2D instance
	- returns:
		- New query instance.
	*/
	public static func create(_ coordinate: CLLocationCoordinate2D) -> Self {
		return VenuesQuery(city: nil, coordinate: coordinate)
	}

	/**
	Create query to search by city name.
	- parameters:
		- city: 	City name, like "Amsterdam, NL"
	- returns:
		- New query instance.
	*/
	public static func create(_ city: String) -> Self {
		return VenuesQuery(city: city, coordinate: nil)
	}
}
