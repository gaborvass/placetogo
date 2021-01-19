//
//  LikesView.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import UIKit

class LikesView: UIView {

	fileprivate var likesLabel = UILabel()
	fileprivate var likesImageView = UIImageView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func updateContent(count: Int) {
		self.likesLabel.text = "\(count)"
	}

	fileprivate func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = UIDesign.Colors.semiTransparentViewBackground
		self.layer.cornerRadius = 8

		self.setupLikesImageView()
		self.setupLikesLabel()
	}

	fileprivate func setupLikesImageView() {
		self.likesImageView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(self.likesImageView)

		self.likesImageView.image = UIImage(systemName: "hand.thumbsup")?.withTintColor(UIDesign.Colors.label, renderingMode: .alwaysOriginal)
		NSLayoutConstraint.activate([
			self.likesImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
			self.likesImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			self.likesImageView.heightAnchor.constraint(equalToConstant: 20),
			self.likesImageView.widthAnchor.constraint(equalToConstant: 20),
		])
	}

	fileprivate func setupLikesLabel() {
		self.likesLabel.translatesAutoresizingMaskIntoConstraints = false
		self.likesLabel.font = UIDesign.Fonts.label
		self.likesLabel.textColor = UIDesign.Colors.label
		self.addSubview(self.likesLabel)

		NSLayoutConstraint.activate([
			self.likesLabel.trailingAnchor.constraint(equalTo: self.likesImageView.leadingAnchor, constant: -4),
			self.likesLabel.centerYAnchor.constraint(equalTo: self.likesImageView.centerYAnchor),
			self.likesLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}

}
