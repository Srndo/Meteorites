//
//  TabBarViewController.swift
//  Meteorites
//
//  Created by Simon Sestak on 23/08/2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    var viewModel: TabBarViewModel

    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Each time the tab bar disappears, the structure needs to be deinitialized.
        // Alert the view model to perform pre-deinitialization actions.
        viewModel.finish()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        roundTabBar()
        setColors()
    }

    private func roundTabBar() {
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.layer.cornerRadius = Theme.Radius.barRadius
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func setColors() {
        tabBar.backgroundColor = Theme.BackgroundColor.tabBar
        tabBar.tintColor = Theme.TintColor.selectedItem
        tabBar.unselectedItemTintColor = Theme.TintColor.unselectedItem
    }
}
