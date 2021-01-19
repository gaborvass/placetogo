//
//  VenueOverlayView.swift
//  PlaceToGo
//
//  Created by Gábor Vass on 18/01/2021.
//

import Foundation
import MapKit
import FourSquareAPI

class VenueAnnotation: NSObject, MKAnnotation {
    let venue: VenueViewModel

    var coordinate: CLLocationCoordinate2D {
		CLLocationCoordinate2D(latitude: venue.latitude, longitude: venue.longitude)
    }
    var title: String? {
        venue.name
    }

    required init(_ venue: VenueViewModel) {
        self.venue = venue
    }
}

class VenueOverlayView: MKAnnotationView {

	fileprivate static var cache: NSCache<NSString, UIImage> = NSCache()

	fileprivate lazy var placeholderIcon: UIImage = {
		return UIImage(systemName: "house") ?? UIImage()
	}()

    override var annotation: MKAnnotation? {
        willSet {
            canShowCallout = true
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
			if let newAnnotation = newValue as? VenueAnnotation {
				image = loadIcon(newAnnotation)
			}
        }
    }

	override func prepareForDisplay() {
		super.prepareForDisplay()
	}
    
	fileprivate func loadIcon(_ annotation: MKAnnotation?) -> UIImage? {
		guard let venueAnnotation = annotation as? VenueAnnotation else {
			return self.placeholderIcon
		}
		guard let imageURL = venueAnnotation.venue.iconURL else {
			return self.placeholderIcon
		}
		if let cachedImage = Self.cache.object(forKey: imageURL.absoluteString as NSString) {
			return cachedImage
		}
		guard let imageData = try? Data(contentsOf: imageURL), let image = UIImage(data: imageData) else {
			return self.placeholderIcon
		}
		Self.cache.setObject(image, forKey: imageURL.absoluteString as NSString)
		return image
	}

}
