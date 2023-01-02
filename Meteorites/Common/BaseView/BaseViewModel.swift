//
//  BaseViewModel.swift
//  Meteorites
//
//  Created by Simon Sestak on 24/08/2021.
//

import Foundation

class BaseViewModel: ShowLoading {
    weak var coordinator: Coordinator?
    let appContext: AppContext
    let apiService: ApiService
    let databaseService: DatabaseService
    var showLoading: Observable<Bool> = Observable(false)

    init(appContext: AppContext, coordinator: Coordinator?) {
        self.appContext = appContext
        self.coordinator = coordinator
        apiService = appContext.apiService
        databaseService = appContext.databaseService
    }

    /// Unbind listeners and if needed notify the coordinator.
    func finish() {
        showLoading.unbind()
        coordinator?.finish()
    }
}
