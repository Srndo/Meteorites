//
//  UIView.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import UIKit

extension UIView {
    class func instantiateFromNib<T: UIView>(viewType: T.Type) -> T {
        // swiftlint:disable:next force_cast
        Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as! T
    }

    class func instantiateFromNib() -> Self {
        instantiateFromNib(viewType: self)
    }
}
