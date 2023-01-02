//
//  Storyboarded.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import UIKit

protocol Storyboarded {
    static func instantiate(name: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(name: String) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        // swiftlint:disable:next force_cast
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
