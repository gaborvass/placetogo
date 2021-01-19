//
//  DataProvider.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 15/01/2021.
//

import Foundation

protocol DataProvider {
	func fetch(_ from: URL, then handler: @escaping (Result<Data, FourSquareSDKError>) -> Void)
}
