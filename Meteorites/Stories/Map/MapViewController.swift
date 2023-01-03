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
    var locationManager: CLLocationManager { viewModel.appContext.locationManager }

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        map.delegate = self

        viewModel.meteorites.bind { [weak self] meteorites in
            meteorites.forEach { self?.createPin(for: $0) }
        }
    }

    private func createPin(for meteorite: Meteorite) {
        guard let pin = CustomAnnotation(meteorite: meteorite) else { return }
        map.addAnnotation(pin)
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
