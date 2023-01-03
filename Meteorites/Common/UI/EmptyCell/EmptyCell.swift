//
//  EmptyCell.swift
//  Meteorites
//
//  Created by Simon Sestak on 03/01/2023.
//

import UIKit

class EmptyCell: UITableViewCell {
    @IBOutlet var label: UILabel!

    var viewModel: EmptyCellViewModel!

    func configure(viewModel: EmptyCellViewModel) {
        self.viewModel = viewModel
        setupCell()
    }

    private func setupCell() {
        label.text = viewModel.text
    }
}
