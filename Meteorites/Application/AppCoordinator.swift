//
//  AppCoordinator.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    private let appWindow: UIWindow

    init() {
        appWindow = UIWindow()
        appWindow.frame = UIScreen.main.bounds
        super.init(appContext: AppContext())
    }

    @discardableResult
    override func start() -> UIViewController? {
        let coordinator = TabBarCoordinator(appContext: appContext)
        childCoordinators.append(coordinator)
        let viewController = coordinator.start()
        appWindow.rootViewController = viewController
        appWindow.makeKeyAndVisible()
        return viewController
    }
}
