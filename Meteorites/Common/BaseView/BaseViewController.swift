//
//  BaseViewController.swift
//  Meteorites
//
//  Created by Simon Sestak on 24/08/2021.
//

import UIKit

class BaseViewController<T: BaseViewModel>: UIViewController, HaveLoadingView {
    var viewModel: T!
    var loadingView = LoadingView.instantiateFromNib()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.BackgroundColor.base
        bindLoadingView(on: view)
        hideKeyboardWhenTappedAround()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            viewModel.finish()
        }
    }

    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
