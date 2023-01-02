//
//  SuperTabBarCoordinators.swift
//
//  Created by Simon Sestak on 04/07/2022.
//

import UIKit

protocol SuperTabBarItemCoordinator: RootCoordinator {}

extension SuperTabBarItemCoordinator {
    /**
     Because this coordinator is part of tab bar. The logic of deinitialization is slightly changed.
     View controller doesn't notify view model on viewDidDisappear, instead of that tab bar coordinator notify
     each child (tab) throught child coordinator when tab bar view controller invoke function viewWillDisappear.
     The logic of this is explained in function finish() of TabBarCoordinator.

     This function isnt executed unless you implement it in required function ``Coordinator.finish()``
     */
    func finishTab(with viewModel: BaseViewModel?) {
        for childCoordinator in childCoordinators {
            childCoordinator.finish()
        }
        viewModel?.finish()
        parentCoordinator?.childDidFinish(self)
    }
}

protocol SuperTabBarCoordinator: RootCoordinator {
    func createItemCoordinators() -> [SuperTabBarItemCoordinator]
}

extension SuperTabBarCoordinator {
    /**
     In tab bar each tab cannot react to viewDidDisappear, because this function is called every time tab focus is changed.
     The logic in tab bar structure deinitialization is to deinitialized each child (tab) after tab bar view controller invoke viewWillDisappear.
     After that you can remove reference to tab bar in parent.
     */
    func finish() {
        for childCoordinator in childCoordinators {
            childCoordinator.finish()
        }
        parentCoordinator?.childDidFinish(self)
    }

    func setUpViewControllers(for viewController: UITabBarController) {
        // create coordinators for each TabBarItem
        let itemCoordinators = createItemCoordinators()
        var viewControllers = [UIViewController]()
        itemCoordinators.forEach { coordinator in
            coordinator.parentCoordinator = self
            let viewController = coordinator.start()
            if let itemViewController = embedIntoNavigationController(viewController) {
                viewControllers.append(itemViewController)
            }
        }
        viewController.setViewControllers(viewControllers, animated: false)
        // set child coordinators
        childCoordinators = itemCoordinators
    }

    func embedIntoNavigationController(_ viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else { return nil }
        // embed viewController in NavigationController
        // this is needed if we going to create a hierarchy in TabBarItemView
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
