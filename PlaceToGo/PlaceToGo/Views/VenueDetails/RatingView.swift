//
//  RatingView.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import UIKit

class RatingView: UIView {

	fileprivate var ratingCircle: UIImageView = UIImageView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func updateContent(rating: Int, color: String) {
		let imageName = "\(rating).circle.fill"
		if let ratingImage = UIImage(systemName: imageName)?
			.withTintColor(UIColor(hex: "#\(color)") ?? .white, renderingMode: .alwaysOriginal) {
			ratingCircle.image = ratingImage
		}
	}

	fileprivate func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.ratingCircle.translatesAutoresizingMaskIntoConstraints = false

		self.addSubview(self.ratingCircle)
		NSLayoutConstraint.activate([
			self.ratingCircle.widthAnchor.constraint(equalTo: self.widthAnchor),
			self.ratingCircle.heightAnchor.constraint(equalTo: self.heightAnchor),
		])
	}
}
