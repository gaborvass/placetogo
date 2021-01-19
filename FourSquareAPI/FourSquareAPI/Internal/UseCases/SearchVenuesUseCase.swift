//
//  SearchVenuesUseCase.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation

final class SearchVenuesUseCase: UseCase {

	func execute(_ query: VenuesQuery, success: @escaping ([Venue]) -> Void, failure: @escaping (Error) -> Void) {
		self.internalExecute(.fromVenuesQuery(query),
							 success: success,
							 failure: failure)
	}
}
