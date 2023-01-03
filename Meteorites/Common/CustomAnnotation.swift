//
//  CustomAnnotation.swift
//  Meteorites
//
//  Created by Simon Sestak on 03/01/2023.
//

import MapKit

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
