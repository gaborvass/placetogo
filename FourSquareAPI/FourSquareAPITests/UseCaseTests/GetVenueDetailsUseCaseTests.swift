//
//  FourSquareWrapperTests.swift
//  FourSquareWrapperTests
//
//  Created by Gábor Vass on 15/01/2021.
//

import XCTest
@testable import FourSquareAPI

class GetVenueDetailsUseCaseTests: XCTestCase {

    override func setUpWithError() throws {
		let provider = ComponentProvider.production
		provider.injectMock(DataProvider.self) { _ in
			return LocalDataProvider()
		}
		provider.injectMock(ConfigReader.self) { _ in
			return MockConfigReader()
		}
    }

    override func tearDownWithError() throws {
    }

    func test_getVenue_venueDetailsReturned() throws {
		// Arrange
		let expect = expectation(description: "getVenue")
		var returnedVenueDetails: VenueDetails?
		var returnedError: Error?

		// Act
		GetVenueDetailsUseCase().execute("52483fe9498ea0a836e5fbff", success: { venueDetails in
			returnedVenueDetails = venueDetails
			expect.fulfill()
		}, failure: { error in
			returnedError = error
			expect.fulfill()
		})

		// Assert
		wait(for: [expect], timeout: .infinity)

		XCTAssertNil(returnedError)
		XCTAssertNotNil(returnedVenueDetails)
	}
}
//
//GetVenueDetailsUseCase().execute("5b1116052db4a9002c2e9148", success: { venue in
//	print(venue)
//	expect.fulfill()
//}, failure: { error in
//	print(error)
//	expect.fulfill()
//})
