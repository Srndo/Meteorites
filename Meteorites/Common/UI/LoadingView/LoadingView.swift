//
//  LoadingViewController.swift
//  Meteorites
//
//  Created by Simon Sestak on 20/09/2021.
//

import UIKit

class LoadingView: UIView {
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var loadingActivityIndicatorView: UIActivityIndicatorView!

    override func awakeFromNib() {
        setup()
    }

    private func setupBlur() {
        blurView.effect = UIBlurEffect(style: .dark)
        blurView.alpha = Theme.LoadingView.blurEfectAlpha
    }

    private func setupIndicator() {
        if #available(iOS 13.0, *) {
            loadingActivityIndicatorView.style = .medium
        } else {
            loadingActivityIndicatorView.style = .gray
        }
        loadingActivityIndicatorView.color = Theme.LoadingView.indicatorColor
        loadingActivityIndicatorView.startAnimating()
    }

    private func setup() {
        backgroundColor = Theme.BackgroundColor.overlay.withAlphaComponent(0.2)
        setupBlur()
        setupIndicator()
    }
}
