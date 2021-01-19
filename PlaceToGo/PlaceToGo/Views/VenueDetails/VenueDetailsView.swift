//
//  VenueDetailsView.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import UIKit

final class VenueDetailsView: UIView {

	fileprivate var photoImageView = PlaceToGoUIImageView()
	fileprivate var nameLabel = UILabel()
	fileprivate var ratingView = RatingView()
	fileprivate var likesView = LikesView()
	fileprivate var addressView = AddressView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func updateContent(_ venueDetails: VenueDetailsViewModel) {
		self.photoImageView.setRemoteImage(with: venueDetails.photoURL, placeholder: "img_placeholder")
		if let rating = venueDetails.rating, let ratingColor = venueDetails.ratingColor {
			self.ratingView.updateContent(rating: rating,
										  color: ratingColor)
		} else {
			self.ratingView.isHidden = true
		}
		self.ratingView.isHidden = false
		self.likesView.updateContent(count: venueDetails.likesCount)
		self.nameLabel.text = venueDetails.name
		self.addressView.updateContent(address: venueDetails.address,
									   city: venueDetails.city,
									   postalCode: venueDetails.postalCode)
	}

	fileprivate func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = UIDesign.Colors.viewBackground

		self.setupPhotoImageView()
		self.setupRatingView()
		self.setupLikesView()
		self.setupAddressView()
	}

	fileprivate func setupPhotoImageView() {
		self.photoImageView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(self.photoImageView)

		NSLayoutConstraint.activate([
			self.photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
			self.photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
			self.photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
			self.photoImageView.heightAnchor.constraint(equalToConstant: 200),
		])

		self.photoImageView.layer.cornerRadius = 8
		self.photoImageView.clipsToBounds = true
	}

	fileprivate func setupRatingView() {
		self.ratingView.translatesAutoresizingMaskIntoConstraints = false
		self.photoImageView.addSubview(self.ratingView)

		NSLayoutConstraint.activate([
			self.ratingView.trailingAnchor.constraint(equalTo: self.photoImageView.trailingAnchor, constant: -4),
			self.ratingView.topAnchor.constraint(equalTo: self.photoImageView.topAnchor, constant: 4),
			self.ratingView.heightAnchor.constraint(equalToConstant: 32),
			self.ratingView.widthAnchor.constraint(equalToConstant: 32),
		])
	}

	fileprivate func setupLikesView() {
		self.likesView.translatesAutoresizingMaskIntoConstraints = false
		self.photoImageView.addSubview(self.likesView)

		NSLayoutConstraint.activate([
			self.likesView.trailingAnchor.constraint(equalTo: self.photoImageView.trailingAnchor, constant: -8),
			self.likesView.bottomAnchor.constraint(equalTo: self.photoImageView.bottomAnchor, constant: -8),
			self.likesView.heightAnchor.constraint(equalToConstant: 32),
			self.likesView.widthAnchor.constraint(equalToConstant: 80),
		])
	}

	fileprivate func setupAddressView() {
		self.addressView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(self.addressView)

		NSLayoutConstraint.activate([
			self.addressView.leadingAnchor.constraint(equalTo: self.photoImageView.leadingAnchor),
			self.addressView.trailingAnchor.constraint(equalTo: self.photoImageView.trailingAnchor),
			self.addressView.topAnchor.constraint(equalTo: self.photoImageView.bottomAnchor, constant: 8),
			self.addressView.heightAnchor.constraint(equalToConstant: 70)
		])
	}

}
