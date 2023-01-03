//
//  DatabaseService.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import PromiseKit
import RealmSwift

class DatabaseService {
    enum Errors: Error {
        case realmNotExists
    }

    var realm: Realm?

    init() {
        realm = try? Realm()
        print(realm?.configuration.fileURL ?? "Realm file doesnt exist")
    }

    func create<T: Object>(object: T) -> Promise<T> {
        guard let realm = realm else { return Promise { $0.reject(Errors.realmNotExists) } }
        return Promise { seal in
            realm.writeAsync {
                realm.add(object, update: .modified)
                seal.fulfill(object)
            }
        }
    }

    func create<T: Object>(objects: [T]) -> Promise<[T]> {
        guard let realm = realm else { return Promise { $0.reject(Errors.realmNotExists) } }
        return Promise { seal in
            realm.writeAsync {
                objects.forEach { realm.add($0, update: .modified) }
                seal.fulfill(objects)
            }
        }
    }

    func getElementsFromDB<T: Object>(of _: T.Type) -> [T]? {
        realm?.objects(T.self).toArray()
    }

    func getElementsFromDBFiltred<T: Object>(of _: T.Type, by filter: String, args: Any...) -> [T]? {
        realm?.objects(T.self).filter(filter, args).toArray()
    }
}

extension Results {
    func toArray() -> [Element] { compactMap { $0 } }
}
