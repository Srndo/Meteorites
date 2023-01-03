//
//  ListViewController.swift
//  Meteorites
//
//  Created by Simon Sestak on 02/01/2023.
//

import UIKit

class ListViewController: BaseViewController<ListViewModel>, Storyboarded {
    @IBOutlet var tableView: UITableView!

    private let refreshControl = UIRefreshControl()
    private var registeredCells: Set<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(sendRequest(_:)), for: .valueChanged)
        viewModel.meteorites.bind { [weak self] in
            self?.registerCells()
            self?.tableView.reloadData()
        }
    }

    @objc private func sendRequest(_: Any) {
        viewModel.sendRequest()
            .ensure { [weak self] in
                self?.refreshControl.endRefreshing()
            }.cauterize()
    }

    private func registerCells() {
        guard viewModel.meteorites.value.count != 0 else {
            let reusableIdentifier = EmptyCellViewModel.reusableIdentifier
            registerCell(with: reusableIdentifier)
            return
        }
        let reusableIdentifier = ListCellViewModel.reusableIdentifier
        registerCell(with: reusableIdentifier)
    }

    private func registerCell(with reusableIdentifier: String) {
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
        let meteoritesCount = viewModel.meteorites.value.count
        return meteoritesCount == 0 ? 1 : meteoritesCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        guard let cellViewModel = viewModel.getCellViewModel(for: indexPath) else {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyCellViewModel.reusableIdentifier,
                                                     for: indexPath) as! EmptyCell
            cell.configure(viewModel: EmptyCellViewModel(text: "You have 0 meteorites fetched, please swipe down."))
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: ListCellViewModel.reusableIdentifier,
                                                 for: indexPath) as! ListCell
        // swiftlint:enable force_cast
        cell.configure(viewModel: cellViewModel)
        return cell
    }
}
