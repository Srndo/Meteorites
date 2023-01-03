//
//  MapViewModel.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import Foundation
import RealmSwift

class MapViewModel: BaseViewModel {
    var meteorites: Observable<[Meteorite]> = Observable([])
    var notificationToken: NotificationToken?

    override init(appContext: AppContext, coordinator: Coordinator?) {
        super.init(appContext: appContext, coordinator: coordinator)
        bindListener()
    }

    private func bindListener() {
        notificationToken = databaseService.bindListener(
            for: Meteorite.self,
            reactionToChanges: { [weak self] results in
                switch results {
                case let .error(error):
                    print(error)
                default:
                    self?.meteorites.value = self?.databaseService.getElementsFromDB(of: Meteorite.self) ?? []
                }
            }
        )
    }
}
