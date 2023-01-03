//
//  Collection.swift
//  Meteorites
//
//  Created by Simon Sestak on 03/01/2023.
//

import Foundation

extension Collection {
    // usage: array[safe: index]
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
