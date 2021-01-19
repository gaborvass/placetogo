//
//  RangeView.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import UIKit

class RangeView: UIView {
	var onRangeChanged: ((Int) -> Void)?

	fileprivate let stepper = UIStepper()
	fileprivate var stepperValue = 1 // value in km
	fileprivate let rangeValueLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	fileprivate func setup() {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = UIDesign.Colors.viewBackground
		self.layer.cornerRadius = 8

		self.setupRangeStepper()
		self.setupRangeValueLabel()
	}

	fileprivate func setupRangeStepper() {
		self.stepper.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(self.stepper)

		self.stepper.autorepeat = false
		self.stepper.value = 1
		self.stepper.isContinuous = false
		self.stepper.minimumValue = 1
		self.stepper.maximumValue = 10
		self.stepper.stepValue = 1
		self.stepper.addTarget(self, action: #selector(onStepperValueChanged), for: .valueChanged)

		NSLayoutConstraint.activate([
			self.stepper.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
			self.stepper.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
	}

	fileprivate func setupRangeValueLabel() {
		self.rangeValueLabel.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(self.rangeValueLabel)

		self.rangeValueLabel.text = "\(self.stepperValue) km"

		NSLayoutConstraint.activate([
			self.rangeValueLabel.leadingAnchor.constraint(equalTo: self.stepper.trailingAnchor, constant: 8),
			self.rangeValueLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
			self.rangeValueLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
		])
	}

	@objc
	fileprivate func onStepperValueChanged() {
		self.stepperValue = Int(self.stepper.value)
		self.rangeValueLabel.text = "\(self.stepperValue) km"
		// notify listener in meters
		self.onRangeChanged?(self.stepperValue * 1000)
	}
}
