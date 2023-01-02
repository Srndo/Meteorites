//
//  TabBarCoordinator.swift
//  Meteorites
//
//  Created by Simon Sestak on 23/08/2021.
//

import UIKit

class TabBarCoordinator: Coordinator, SuperTabBarCoordinator {
    override func start() -> UIViewController? {
        let viewModel = TabBarViewModel(appContext: appContext, coordinator: self)
        let viewController = TabBarViewController(viewModel: viewModel)
        setUpViewControllers(for: viewController)
        return viewController
    }

    func createItemCoordinators() -> [SuperTabBarItemCoordinator] {
        let listCoordinator = ListCoordinator(appContext: appContext)
        let mapCoordinator = MapCoordinator(appContext: appContext)
        return [listCoordinator, mapCoordinator]
    }
}
