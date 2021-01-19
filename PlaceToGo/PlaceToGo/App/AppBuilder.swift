//
//  AppBuilder.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import UIKit

struct AppBuilder {
	static func production() -> UIViewController {
		let venueDetailsModel = VenueDetailsModel()
		let detailsView = VenueDetailsViewController(venueDetailsModel)

		let mapView = MapController()
		mapView.onVenueSelected = { venueId in
			detailsView.selectedVenueId = venueId
			mapView.present(detailsView, animated: true, completion: nil)
		}
		return mapView
	}
}
