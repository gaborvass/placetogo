//
//  FourSquareWrapperError.swift
//  FourSquareWrapper
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation

public enum FourSquareSDKError: String, Error {
	// Network error
	case networkError
	// Invalid JSON data error
	case parserError
	// Error response received, like quota exceeded error for premium endpoints (venue details)
	case errorReceived
	// Missing client ID error
	case missingClientID
	// Missing client Secret error
	case missingClientSecret
	// Internal SDK error, report as bug
	case internalSDKError
}

extension FourSquareSDKError: LocalizedError {
	public var errorDescription: String? {
		switch self {
			case .networkError:
				return "Network connection error"
			case .parserError:
				return "Error while parsing data"
			case .errorReceived:
				return "Error received from backend"
			case .missingClientID:
				return "Missing client id"
			case .missingClientSecret:
				return "Missing client secret"
			case .internalSDKError:
				return "Internal error"
		}
	}
}
