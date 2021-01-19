//
//  PlaceToGoUIImageView.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import UIKit

class PlaceToGoUIImageView: UIImageView {

	private static var cache: NSCache<NSString, UIImage> = NSCache()

	func setRemoteImage(with url: URL?, placeholder: String) {
		self.image = UIImage(named: placeholder)
		guard let remoteURL = url else {
			return
		}
		if let cachedImage = Self.cache.object(forKey: remoteURL.absoluteString as NSString) {
			return self.image = cachedImage
		}
		self.image = UIImage(named: placeholder)
		self.downloadRemoteImage(remoteURL)
	}

	fileprivate func downloadRemoteImage(_ url: URL) {
		DispatchQueue.global().async {
			if let data = try? Data(contentsOf: url), let downloadedImage = UIImage(data: data) {
				Self.cache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
				DispatchQueue.main.async {
					self.image = downloadedImage
				}
			}
		}
	}
}
