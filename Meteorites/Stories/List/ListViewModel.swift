//
//  ListViewModel.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import Foundation
import PromiseKit
import RealmSwift

class ListViewModel: BaseViewModel {
    var meteorites: Observable<[Meteorite]> = Observable([])
    var notificationToken: NotificationToken?

    override init(appContext: AppContext, coordinator: Coordinator?) {
        super.init(appContext: appContext, coordinator: coordinator)
        bindListener()
    }

    func sendRequest() -> Promise<Void> {
        let endPoint = EndPoints.filtered(fromDate: "2011-01-01T00:00:00".getDate(), fall: .fell)
        let urlTaks = URLTask(endPoint: endPoint)
        return apiService.request(of: Meteorits.self, urlTask: urlTaks)
            .done { [weak self] meteorites in
                self?.saveMeteorites(meteorites)
            }.then {
                Promise { $0.fulfill_() }
            }
    }

    private func saveMeteorites(_ meteorites: Meteorits) {
        databaseService.create(objects: meteorites)
            .done { meteorites in
                print("Saved \(meteorites.count) meteorites")
            }.catch { error in
                print(error)
            }
    }

    func getCellViewModel(for indexPath: IndexPath) -> ListCellViewModel? {
        if let meteorite = meteorites.value[safe: indexPath.row] {
            return ListCellViewModel(meteorite: meteorite)
        } else {
            return nil
        }
    }

    private func bindListener() {
        notificationToken = databaseService.bindListener(for: Meteorite.self,
                                                         reactionToChanges: { [weak self] results in
                                                             switch results {
                                                             case let .error(error):
                                                                 print(error)
                                                             default:
                                                                 self?.meteorites.value = self?.databaseService.getElementsFromDB(of: Meteorite.self) ?? []
                                                             }
                                                         })
    }
}
