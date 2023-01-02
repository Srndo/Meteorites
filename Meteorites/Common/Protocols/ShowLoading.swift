//
//  ShowLoading.swift
//  Meteorites
//
//  Created by Simon Sestak on 05/07/2022.
//

import UIKit

/// This protocol should be implemented by view models.
/// If the view controller of the given view model does not implement the ``HaveLoadingView``,
/// this protocol has no effect
protocol ShowLoading: AnyObject {
    var showLoading: Observable<Bool> { get set }
}

extension ShowLoading {
    func showLoading() {
        showLoading.value = true
    }

    func hideLoading() {
        showLoading.value = false
    }
}

/// This protocol should be implemented by view controllers or the view itself.
protocol HaveLoadingView: AnyObject {
    associatedtype ViewModelType: ShowLoading
    var viewModel: ViewModelType! { get set }
    var loadingView: LoadingView { get }
    func bindLoadingView(on view: UIView)
}

extension HaveLoadingView {
    func bindLoadingView(on view: UIView) {
        loadingView.frame = view.bounds
        viewModel.showLoading.bind { [weak self] show in
            guard let self = self
            else { return }
            if show {
                guard !view.subviews.contains(self.loadingView)
                else { return }
                view.addSubview(self.loadingView)
            } else {
                self.loadingView.removeFromSuperview()
            }
        }
    }
}
