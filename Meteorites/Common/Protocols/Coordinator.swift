//
//  Coordinator.swift
//
//  Created by Simon Sestak on 02/01/2023.
//

import UIKit

/// This protocol is used only as a mark of the root coordinator in hierarchy (for stoppage).
protocol RootCoordinator: Coordinator {}

class Coordinator {
    let appContext: AppContext
    var childCoordinators: [Coordinator]
    weak var parentCoordinator: Coordinator?

    /// Initialize view controller with appropriate viewmodel and show initialized view.
    @discardableResult
    func start() -> UIViewController? { return nil }

    /// Notify the parent that the child has finished their task and is ready to deinit.
    func finish() {}

    init(appContext: AppContext) {
        self.appContext = appContext
        childCoordinators = []
    }

    /// Remove the child from his parent.
    final func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
        }
    }

    /// Loop in which it will release the individual structure models unless you come across the ``RootCoordinator``.
    @discardableResult
    final func freeHierarchyUpToRoot() -> RootCoordinator? {
        var parent = parentCoordinator
        var child: Coordinator? = self
        while !(child?.isRootType() ?? true) {
            parent?.childDidFinish(child)
            child = parent
            parent = parent?.parentCoordinator
        }
        return child as? RootCoordinator
    }

    /// Before removing from parent need to check if this coordinator contains childs.
    /// If coordinator contains child, cannot remove reference because this data block will be lost,
    /// and will not be deinitialized.
    /// - Tag: freeHierarchyUpToParent
    final func freeHierarchyUpToParent() {
        if childCoordinators.isEmpty {
            parentCoordinator?.childDidFinish(self)
        }
    }

    final func isAppRoot() -> Bool {
        self is AppCoordinator
    }

    final func isRootType() -> Bool {
        self is RootCoordinator
    }
}
