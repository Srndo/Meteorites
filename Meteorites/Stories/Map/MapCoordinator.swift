//
//  MapCoordinator.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import UIKit

class MapCoordinator: Coordinator, SuperTabBarItemCoordinator {
    override func start() -> UIViewController? {
        let viewController = MapViewController.instantiate(name: "Map")
        let viewModel = MapViewModel(appContext: appContext, coordinator: self)
        viewController.viewModel = viewModel
        let icon = ImageList.mapIcon.getUIImage(renderMode: .alwaysTemplate)
        viewController.tabBarItem = UITabBarItem(title: "Map",
                                                 image: icon,
                                                 selectedImage: icon)
        viewController.view.backgroundColor = .red
        return viewController
    }
}
