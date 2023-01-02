//
//  ImageList.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import UIKit

enum ImageList: String {
    case listIcon
    case mapIcon

    func getUIImage(renderMode: UIImage.RenderingMode? = nil) -> UIImage? {
        guard let renderMode = renderMode else {
            return UIImage(named: rawValue)
        }
        return UIImage(named: rawValue)?.withRenderingMode(renderMode)
    }
}
