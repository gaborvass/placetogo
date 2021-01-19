//
//  AddressView.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import UIKit

class AddressView: UIView {

	fileprivate var addressLabel = UILabel()
	fileprivate var postalCodeLabel = UILabel()
	fileprivate var cityLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func updateContent(address: String?, city: String, postalCode: String?) {
		self.addressLabel.text = address ?? "Not available"
		self.cityLabel.text = city
		self.postalCodeLabel.text = postalCode ?? "Not available"
	}

	fileprivate func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = UIDesign.Colors.viewBackground

		self.setupAddressLabel()
		self.setupCityLabel()
		self.setupPostalCodeLabel()
	}

	fileprivate func setupAddressLabel() {
		self.addressLabel.translatesAutoresizingMaskIntoConstraints = false
		self.addressLabel.font = UIDesign.Fonts.label
		self.addressLabel.textColor = UIDesign.Colors.label
		self.addSubview(self.addressLabel)

		NSLayoutConstraint.activate([
			self.addressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
			self.addressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			self.addressLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
			self.addressLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}

	fileprivate func setupCityLabel() {
		self.cityLabel.translatesAutoresizingMaskIntoConstraints = false
		self.cityLabel.font = UIDesign.Fonts.label
		self.cityLabel.textColor = UIDesign.Colors.label
		self.addSubview(self.cityLabel)

		NSLayoutConstraint.activate([
			self.cityLabel.leadingAnchor.constraint(equalTo: self.addressLabel.leadingAnchor),
			self.cityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			self.cityLabel.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor, constant: 4),
			self.cityLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}

	fileprivate func setupPostalCodeLabel() {
		self.postalCodeLabel.translatesAutoresizingMaskIntoConstraints = false
		self.postalCodeLabel.font = UIDesign.Fonts.label
		self.postalCodeLabel.textColor = UIDesign.Colors.label
		self.addSubview(self.postalCodeLabel)

		NSLayoutConstraint.activate([
			self.postalCodeLabel.leadingAnchor.constraint(equalTo: self.addressLabel.leadingAnchor),
			self.postalCodeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
			self.postalCodeLabel.topAnchor.constraint(equalTo: self.cityLabel.bottomAnchor, constant: 4),
			self.postalCodeLabel.heightAnchor.constraint(equalToConstant: 20)
		])
	}
}
