//
//  UIColorExtension.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
// 	From: https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor

import Foundation
import UIKit

extension UIColor {
	
	public convenience init?(hex: String) {
		let r, g, b: CGFloat

		if hex.hasPrefix("#") {
			let start = hex.index(hex.startIndex, offsetBy: 1)
			let hexColor = String(hex[start...])

			if hexColor.count == 6 {
				let scanner = Scanner(string: hexColor)
				var hexNumber: UInt64 = 0

				if scanner.scanHexInt64(&hexNumber) {
					r = CGFloat((hexNumber & 0xff0000) >> 16) / 255.0
					g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255.0
					b = CGFloat(hexNumber & 0x0000ff) / 255.0

					self.init(red: r, green: g, blue: b, alpha: 1.0)
					return
				}
			}
		}

		return nil
	}
}
