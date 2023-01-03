//
//  ListViewModel.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import Foundation
import RealmSwift

class ListViewModel: BaseViewModel {
    var meteorites: Observable<[Meteorite]> = Observable([])
    var notificationToken: NotificationToken?

    override init(appContext: AppContext, coordinator: Coordinator?) {
        super.init(appContext: appContext, coordinator: coordinator)
        bindListener()
    }

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

    func getCellViewModel(for indexPath: IndexPath) -> ListCellViewModel {
        ListCellViewModel(meteorite: meteorites.value[indexPath.row])
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
