//
//  FourSquareSDK.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation
import CoreLocation

/**
Public API for FourSquareSDK
*/
public class FourSquareSDK {

	/**
	Search venues.
	- parameters:
		- query:	VenuesQuery instance.
		- success:	Callback invoked when operation finished.
		- failure:	Callback invoked when operation failed.
	*/
	public static func searchVenues(query: VenuesQuery, success: @escaping ([Venue]) -> Void, failure: @escaping (Error) -> Void) {
		SearchVenuesUseCase().execute(query, success: success, failure: failure)
	}

	/**
	Get venue details.
	- parameters:
		- id:		Id of the venue..
		- success:	Callback invoked when operation finished.
		- failure:	Callback invoked when operation failed.
	*/
	public static func venueDetails(_ id: String, success: @escaping (VenueDetails) -> Void, failure: @escaping (Error) -> Void) {
		GetVenueDetailsUseCase().execute(id, success: success, failure: failure)
	}

}
