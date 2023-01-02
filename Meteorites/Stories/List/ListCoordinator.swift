//
//  ListCoordinator.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import UIKit

class ListCoordinator: Coordinator, SuperTabBarItemCoordinator {
    override func start() -> UIViewController? {
        let viewController = ListViewController.instantiate(name: "List")
        let viewModel = ListViewModel(appContext: appContext, coordinator: self)
        viewController.viewModel = viewModel
        let icon = ImageList.listIcon.getUIImage()
        viewController.tabBarItem = UITabBarItem(title: "List",
                                                 image: icon,
                                                 selectedImage: icon)
        return viewController
    }
}
