//
//  ListingDetailsViewController.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit
import ImageSlideshow

struct ListingDetailsViewModel {
    let title: String
}

typealias ListingDetailsSnapshot = NSDiffableDataSourceSnapshot<Int, ListingDetailsItem>

protocol ListingDetailsModuleViewInput: Presentable, HUDPresentable {
  /// Setup initial state
    func setupInitialState(viewModel: ListingDetailsViewModel)
  /// Apply snapshot of data to display in collection
  ///
  /// - Parameters:
  ///   - snapshot: Snapshot of data to apply
    func applySnapshot(snapshot: ListingDetailsSnapshot)
}

/// Modules view output
protocol ListingDetailsModuleViewOutput: AnyObject {
  /// Notifies that view is ready
  func viewDidLoad()
    /// Notifies that close button tapped
  func onCloseButtonTapped()
}

final class ListingDetailsViewController: UITableViewController {

    var output: ListingDetailsModuleViewOutput!
    var dataSource: ListingDetailsTableDatasource!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureDataSource()
        output.viewDidLoad()
    }

    private func configureDataSource() {
        dataSource = ListingDetailsTableDatasource(tableView: tableView)
    }

    private func setupUI() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                            target: self,
                                                            action: #selector(didTapCloseButton))
    }

    @objc func didTapCloseButton() { output.onCloseButtonTapped() }
}

extension ListingDetailsViewController: ListingDetailsModuleViewInput {
    func setupInitialState(viewModel: ListingDetailsViewModel) {
        navigationItem.title = viewModel.title
    }

    func applySnapshot(snapshot: ListingDetailsSnapshot) {
        dataSource.apply(snapshot)
    }
}
