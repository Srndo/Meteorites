//
//  AppContext.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import Foundation

class AppContext {
    let apiService: ApiService
    let databaseService: DatabaseService

    init() {
        apiService = ApiService()
        databaseService = DatabaseService()
    }
}
