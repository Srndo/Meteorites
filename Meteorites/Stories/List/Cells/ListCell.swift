//
//  ListCell.swift
//  Meteorites
//
//  Created by Simon Sestak on 03/01/2023.
//

import UIKit

class ListCell: UITableViewCell {
    @IBOutlet var name: UILabel!

    var viewModel: ListCellViewModel!

    func configure(viewModel: ListCellViewModel) {
        self.viewModel = viewModel
        setupCell()
    }

    private func setupCell() {
        name.text = viewModel.name
    }
}
