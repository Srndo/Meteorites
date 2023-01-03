//
//  ListViewController.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import UIKit

class ListViewController: BaseViewController<ListViewModel>, Storyboarded {
    @IBOutlet var tableView: UITableView!
//    @IBOutlet var requestButton: UIButton!

    private var registeredCells: Set<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.meteorites.bind { [weak self] in
            self?.registerCells()
            self?.tableView.reloadData()
        }
    }

//    @IBAction func requestButtonTap(_: Any) {
//        viewModel.sendRequest()
//    }

    private func registerCells() {
        let reusableIdentifier = ListCellViewModel.reusableIdentifier
        guard !registeredCells.contains(reusableIdentifier) else { return }
        let nib = UINib(nibName: reusableIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: reusableIdentifier)
        registeredCells.insert(reusableIdentifier)
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.meteorites.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.getCellViewModel(for: indexPath)

        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCellViewModel.reusableIdentifier,
                                                 for: indexPath) as! ListCell
        // swiftlint:enable force_cast
        cell.configure(viewModel: cellViewModel)
        return cell
    }
}
