//
//  MapViewController.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import CoreLocation
import MapKit
import UIKit

class MapViewController: BaseViewController<MapViewModel>, Storyboarded {
    @IBOutlet var map: MKMapView!

    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        map.delegate = self

        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()

        viewModel.meteorites.bind { [weak self] meteorites in
            meteorites.forEach { self?.createPin(for: $0) }
        }
    }

    private func createPin(for meteorite: Meteorite) {
        guard let pin = CustomAnnotation(meteorite: meteorite) else { return }
        map.addAnnotation(pin)
    }
}

class CustomAnnotation: NSObject, MKAnnotation {
    var identifier: String
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

    init(identifier: String, coordinate: CLLocationCoordinate2D, title: String? = nil, subtitle: String? = nil) {
        self.identifier = identifier
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }

    convenience init?(meteorite: Meteorite) {
        guard let coordinate = meteorite.getLocation() else { return nil }
        self.init(identifier: meteorite.id,
                  coordinate: coordinate,
                  title: meteorite.name,
                  subtitle: meteorite.year != nil ? "Fell in year : \(meteorite.year!)" : nil)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        guard let customAnnotation = annotation as? CustomAnnotation else { return nil }

        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: customAnnotation.identifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: customAnnotation,
                                              reuseIdentifier: customAnnotation.identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = customAnnotation
        }
        annotationView?.image = ImageList.locationPoint.getUIImage(renderMode: .alwaysTemplate)
        return annotationView
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations _: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        map.setRegion(MKCoordinateRegion(center: locValue,
                                         latitudinalMeters: 50,
                                         longitudinalMeters: 50),
                      animated: true)
    }

    func locationManagerDidChangeAuthorization(_: CLLocationManager) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}
