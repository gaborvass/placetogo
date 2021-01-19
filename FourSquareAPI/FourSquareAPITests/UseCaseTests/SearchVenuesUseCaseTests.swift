//
//  FourSquareWrapperTests.swift
//  FourSquareWrapperTests
//
//  Created by Gábor Vass on 15/01/2021.
//

import XCTest
@testable import FourSquareAPI

class SearchVenuesUseCaseTests: XCTestCase {

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

    func test_searchVenues_venuesReturned() throws {
		// Arrange
		let expect = expectation(description: "fetchVenues")
		var returnedVenues: [Venue]?
		var returnedError: Error?

		// Act
		SearchVenuesUseCase().execute(.create("AMS"), success: { venues in
			returnedVenues = venues
			expect.fulfill()
		}, failure: { error in
			returnedError = error
			expect.fulfill()
		})

		// Assert
		wait(for: [expect], timeout: .infinity)

		XCTAssertNil(returnedError)
		XCTAssertNotNil(returnedVenues)
		XCTAssertTrue(returnedVenues?.count != 0)
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
