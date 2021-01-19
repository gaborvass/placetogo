//
//  VenueLikes.swift
//  FourSquareAPI
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation

public struct VenueLikes {
	public let likesCount: Int
}

// MARK: Extension: decodable
extension VenueLikes: Decodable {}
