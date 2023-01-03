//
//  ListViewModel.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import Foundation

class ListViewModel: BaseViewModel {
    func sendRequest() {
        let endPoint = EndPoints.filtered(fromDate: "2011-01-01T00:00:00".getDate(), fall: .fell)
        let urlTaks = URLTask(endPoint: endPoint)
        apiService.request(of: Meteorits.self, urlTask: urlTaks)
            .done { [weak self] meteorites in
                self?.databaseService.create(objects: meteorites)
                    .done { meteorites in
                        print("Saved \(meteorites.count) meteorites")
                    }.catch { error in
                        print(error)
                    }
            }.catch { error in
                print(error)
            }
    }
}
