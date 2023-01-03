//
//  AppContext.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import CoreLocation
import Foundation

class AppContext {
    let apiService: ApiService
    let databaseService: DatabaseService
    let locationManager: CLLocationManager

    init() {
        apiService = ApiService()
        databaseService = DatabaseService()
        locationManager = CLLocationManager()
        // Ask for Authorisation from the User.
        locationManager.requestAlwaysAuthorization()
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
    }
}
