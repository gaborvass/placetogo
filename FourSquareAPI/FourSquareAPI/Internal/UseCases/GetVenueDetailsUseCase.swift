//
//  GetVenueDetailsUseCase.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 17/01/2021.
//

import Foundation

final class GetVenueDetailsUseCase: UseCase {

	func execute(_ venueId: String, success: @escaping (VenueDetails) -> Void, failure: @escaping (Error) -> Void) {
		self.internalExecute(.detail(venueId: venueId),
							 success: success,
							 failure: failure)
	}
}
