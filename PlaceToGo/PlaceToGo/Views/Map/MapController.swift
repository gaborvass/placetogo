//
//  MapController.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import UIKit
import MapKit
import FourSquareAPI

class MapController: UIViewController {

    var onVenueSelected: ((String) -> Void)?

    private let model: MapModel = MapModel()
	private let rangeView = RangeView()

    required init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.register(VenueOverlayView.self, forAnnotationViewWithReuseIdentifier: "venue")
        view.delegate = self
        return view
    }()

    private lazy var stateManager: ViewStateManager = {
        return ViewStateManager(parent: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupModel()
        self.setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(animated)
        self.stateManager.state = .showLoading
    }

	fileprivate func updateAnnotations(_ viewModels: Set<VenueViewModel>) {
		self.mapView.annotations.forEach {
			if let venueAnnotation = $0 as? VenueAnnotation {
				if !viewModels.contains(venueAnnotation.venue) {
					self.mapView.removeAnnotation(venueAnnotation)
				}
			}
		}
		self.mapView.addAnnotations(viewModels.map { venue in
            let ann = VenueAnnotation(venue)
            return ann
        })
    }

    fileprivate func setupView() {
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.mapView)
        NSLayoutConstraint.activate([
            self.mapView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

		self.setupRangeView()
    }

	fileprivate func setupRangeView() {
		self.rangeView.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(self.rangeView)

		NSLayoutConstraint.activate([
			self.rangeView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8),
			self.rangeView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 28),
			self.rangeView.widthAnchor.constraint(equalToConstant: 160),
			self.rangeView.heightAnchor.constraint(equalToConstant: 40),
		])

		self.rangeView.onRangeChanged = { newRange in
			self.stateManager.state = .showLoading
			self.model.updateRange(newRange)
		}
	}

    fileprivate func setupModel() {
        self.model.onDataLoaded = { [weak self] location, venues in
			self?.stateManager.state = .hideLoading
            self?.updateAnnotations(venues)
			self?.showUserLocation(location)
        }
        self.model.onError = { [weak self] error in
			self?.stateManager.state = .showError(error)
        }
    }

	fileprivate func showUserLocation(_ location: CLLocation?) {
		if let location = location {
			self.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, latitudinalMeters: CLLocationDistance(3000), longitudinalMeters: CLLocationDistance(3000)), animated: true)
		}
	}
}

// MARK: Extension: MKMapViewDelegate
extension MapController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let venueAnnotation = view.annotation as? VenueAnnotation {
			self.onVenueSelected?(venueAnnotation.venue.id)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "venue")
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "venue")
        }
		if let annotationView = annotationView {
			annotationView.canShowCallout = true
            annotationView.annotation = annotation
        }
        return annotationView
    }
}
