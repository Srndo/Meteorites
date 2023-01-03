//
//  ListViewModel.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import Foundation
import MapKit
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
        notificationToken = databaseService.bindListener(
            for: Meteorite.self,
            reactionToChanges: { [weak self] results in
                switch results {
                case let .error(error):
                    print(error)
                default:
                    let meteorites = self?.databaseService.getElementsFromDB(of: Meteorite.self) ?? []
                    guard let userLocation = self?.appContext.locationManager.location?.coordinate else {
                        self?.meteorites.value = meteorites
                        return
                    }

                    let pointToCompare = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)

                    self?.meteorites.value = meteorites.sorted(by: { lhs, rhs in
                        guard let lhsLocation = lhs.getLocation() else { return false }
                        guard let rhsLocation = rhs.getLocation() else { return false }
                        let lhsCLLoc = CLLocation(latitude: lhsLocation.latitude, longitude: lhsLocation.longitude)
                        let rhsCLLoc = CLLocation(latitude: rhsLocation.latitude, longitude: rhsLocation.longitude)
                        return lhsCLLoc.distance(from: pointToCompare) < rhsCLLoc.distance(from: pointToCompare)
                    })
                }
            }
        )
    }
}
