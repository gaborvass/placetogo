//
//  DataDecoder.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 16/01/2021.
//

import Foundation

protocol DataDecoder {
	func decode<T>(_ data: Data, of type: RequestType) -> Result<T, FourSquareSDKError>
}
