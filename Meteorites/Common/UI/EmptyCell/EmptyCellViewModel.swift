//
//  EmptyCellViewModel.swift
//  Meteorites
//
//  Created by Simon Sestak on 03/01/2023.
//

import Foundation

class EmptyCellViewModel {
    static let reusableIdentifier = String(describing: EmptyCell.self)
    let text: String

    init(text: String) {
        self.text = text
    }
}
