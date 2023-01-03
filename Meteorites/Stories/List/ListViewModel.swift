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
            .done { meteorites in
                print(meteorites)
            }.catch { error in
                print(error)
            }
    }
}
