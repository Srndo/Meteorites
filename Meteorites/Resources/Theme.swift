//
//  Theme.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import UIKit

class Theme {
    enum BackgroundColor {
        static let base = colorByInterfaceStyle(light: .white, dark: .black)
        static let tabBar = UIColor.systemGray6
        static let overlay = colorByInterfaceStyle(light: .black,
                                                   dark: .white).withAlphaComponent(0.2)
    }

    enum Radius {
        static let barRadius = CGFloat(30)
    }

    enum TintColor {
        static let selectedItem = UIColor.systemBlue
        static let unselectedItem = UIColor.systemGray
    }

    enum LoadingView {
        static let blurEfectAlpha = CGFloat(0.75)
        static let indicatorColor = colorByInterfaceStyle(light: .white, dark: .black)
    }

    private static func colorByInterfaceStyle(light: UIColor, dark: UIColor? = nil) -> UIColor {
        UIColor { (traitCollection: UITraitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark, let dark {
                return dark
            }
            return light
        }
    }
}
