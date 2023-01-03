//
//  ListCellViewModel.swift
//  Meteorites
//
//  Created by Simon Sestak on 03/01/2023.
//

import Foundation

class ListCellViewModel {
    static let reusableIdentifier = String(describing: ListCell.self)
    let name: String?

    init(meteorite: Meteorite) {
        name = meteorite.name
    }
}
