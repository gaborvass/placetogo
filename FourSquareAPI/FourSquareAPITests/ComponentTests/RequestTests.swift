//
//  RequestTests.swift
//  FourSquareAPITests
//
//  Created by Gábor Vass on 19/01/2021.
//

import Foundation
import XCTest
@testable import FourSquareAPI

class RequestTests: XCTestCase {

	override func setUpWithError() throws {
	}

	override func tearDownWithError() throws {
	}

	func test_searchByCityQuery_requestURLReturned() throws {
		// Arrange
		let query = VenuesQuery.create("AMS")

		// Act
		let request = Request.fromVenuesQuery(query)

		// Assert
		XCTAssertNotNil(request)
		XCTAssertNotNil(request.url)
		XCTAssertEqual(request.url?.path, "/v2/venues/explore")
	}
}
