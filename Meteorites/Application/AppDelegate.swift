//
//  AppDelegate.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    private var appCoordinator: AppCoordinator!

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        appCoordinator = AppCoordinator()
        appCoordinator.start()
        return true
    }
}
