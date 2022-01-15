//
//  HomeModulePresenter.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Foundation

final class HomeModulePresenter: HomeModuleViewOutput, HomeModuleInteractorOutput {

    weak var view: HomeModuleViewInput!
    var interactor: HomeModuleInteractorInput

    private var listings: [Listing] = []
    /// Router
    var router: HomeModuleRouterInput

    /// Initialization
    ///
    /// - Parameters:
    ///   - view: View
    ///   - interactor: Interactor
    ///   - router: Router
    init(view: HomeModuleViewInput,
         interactor: HomeModuleInteractorInput,
         router: HomeModuleRouterInput) {
      self.view = view
      self.interactor = interactor
      self.router = router
    }

    func viewDidLoad() {
        view?.setupInitialState()
        reloadData()
    }

    func didSelectItem(at indexPath: IndexPath) {
        router.showListingDetails(listings[indexPath.item])
    }

    func interactorDidFinishLoading(_ listings: [Listing]) {
        view?.endRefreshing()
        let viewModels = listings.map { ListingCollectionViewCellViewModel(listing: $0) }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModels)
        self.listings = listings
        view?.applySnapshot(snapshot: snapshot)
    }

    func interactorDidFailWithError(_ error: Error) {
        view?.endRefreshing()
        view?.showEmptyView()
        router.showErrorAlert(error, onRetry: reloadData)
    }

    func reloadData() {
        view?.showHUD()
        interactor.reloadData()
    }
}
