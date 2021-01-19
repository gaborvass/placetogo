//
//  VenueDetailsViewController.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import UIKit
import FourSquareAPI

class VenueDetailsViewController: UIViewController {

	var selectedVenueId: String? {
		didSet {
			if let venueId = selectedVenueId {
				self.stateManager.state = .showLoading
				self.model.loadDetails(venueId)
			}
		}
	}

	fileprivate let model: VenueDetailsModel

	required init(_ model: VenueDetailsModel) {
		self.model = model
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	fileprivate lazy var detailsView: VenueDetailsView = {
		return VenueDetailsView()
	}()

	fileprivate lazy var stateManager: ViewStateManager = {
		return ViewStateManager(parent: self)
	}()

	override func viewWillAppear(_ animated: Bool) {
		self.updateViewConstraints()
		self.navigationController?.setNavigationBarHidden(false, animated: true)
		super.viewWillAppear(animated)
		self.stateManager.state = .showLoading
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupModel()
		setupView()
	}

	override func updateViewConstraints() {
		self.view.frame.size.height = UIScreen.main.bounds.height - 220
		self.view.frame.origin.y = 320
		self.view.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
		super.updateViewConstraints()
	}

	fileprivate func setupModel() {
		self.model.onDetailsLoaded = { venueDetails in
			self.detailsView.updateContent(venueDetails)
			self.stateManager.state = .hideLoading
			self.detailsView.isHidden = false
		}
		self.model.onError = { error in
			self.stateManager.state = .showError(error)
		}
	}

	fileprivate func setupView() {
		self.view.backgroundColor = UIDesign.Colors.viewBackground
		self.view.addSubview(self.detailsView)
		NSLayoutConstraint.activate([
			self.detailsView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
			self.detailsView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
			self.detailsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			self.detailsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
		])
		self.detailsView.isHidden = true
	}
}

