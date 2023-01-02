//
//  ListViewController.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import UIKit

class ListViewController: BaseViewController<ListViewModel>, Storyboarded {
    @IBOutlet var requestButton: UIButton!

    @IBAction func requestButtonTap(_: Any) {
        viewModel.sendRequest()
    }
}
