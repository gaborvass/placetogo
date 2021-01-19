//
//  AsyncUseCase.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation

open class UseCase {

	fileprivate var dataProvider: DataProvider
	fileprivate var dataDecoder: DataDecoder
	fileprivate var executors: Executors
	fileprivate var configuration: Configuration
	fileprivate var requestParamProvider: RequestParameterProvider

	init(_ componentProvider: ComponentProvider = ComponentProvider.production) {
		self.requestParamProvider = componentProvider.provide(RequestParameterProvider.self)
		self.dataProvider = componentProvider.provide(DataProvider.self)
		self.dataDecoder = componentProvider.provide(DataDecoder.self)
		self.executors = componentProvider.provide(Executors.self)
		self.configuration = componentProvider.provide(Configuration.self)
	}

	func internalExecute<T>(_ request: Request, success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {
		// validate configuration first
		self.executors.bg {
			do {
				try self.validateConfiguration()
				let requestURL = try self.generateRequestURL(request.url)
				self.dataProvider.fetch(requestURL, then: { result in
					guard let data = self.processFetchResult(result, failure: failure) else {
						return
					}
					guard let decodedResult: T = self.decodeFetchResult(data, type: request.type, failure: failure) else {
						return
					}
					self.executors.ui {
						success(decodedResult)
					}
				})
			} catch {
				self.executors.ui {
					failure(error)
				}
			}

		}
	}

	fileprivate func processFetchResult(_ result: Result<Data, FourSquareSDKError>, failure: @escaping (FourSquareSDKError) -> Void) -> Data? {
		switch result {
			case .success(let data):
				return data
			case .failure(let error):
				self.executors.ui {
					failure(error)
				}
				return nil
		}
	}

	fileprivate func decodeFetchResult<T>(_ data: Data, type: RequestType,  failure: @escaping (FourSquareSDKError) -> Void) -> T? {
		let decodeResult: Result<T, FourSquareSDKError> = self.dataDecoder.decode(data, of: type)
		switch decodeResult {
			case .success(let decoded):
				return decoded
			case .failure(let error):
				self.executors.ui {
					failure(error)
				}
				return nil
		}
	}

}

// MARK: Extension: request url generator
extension UseCase {
	fileprivate func generateRequestURL(_ from: URL?) throws -> URL {
		guard let requestURL = from else {
			throw FourSquareSDKError.internalSDKError
		}
		guard let completeRequestURL = requestURL.appendingQueryParameters(self.requestParamProvider.defaultParameters) else {
			throw FourSquareSDKError.internalSDKError
		}
		return completeRequestURL
	}
}

// MARK: Extension: validator
extension UseCase {
	fileprivate func validateConfiguration() throws {
		guard let _ = configuration.clientID else {
			throw FourSquareSDKError.missingClientID
		}
		guard let _ = configuration.clientSecret else {
			throw FourSquareSDKError.missingClientSecret
		}
	}
}
