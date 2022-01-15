//
//  ListingDetailsModulePresenter.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Foundation

final class ListingDetailsModulePresenter: ListingDetailsModuleViewOutput {

    weak var view: ListingDetailsModuleViewInput!
    /// Router
    var router: ListingDetailsModuleRouterInput
    private let item: Listing

    /// Initialization
    ///
    /// - Parameters:
    ///   - view: View
    ///   - router: Router
    init(item: Listing,
         view: ListingDetailsModuleViewInput,
         router: ListingDetailsModuleRouterInput) {
      self.view = view
      self.router = router
      self.item = item
    }

    func viewDidLoad() {
        view?.setupInitialState(viewModel: .init(title: item.name))
        var snapshot = ListingDetailsSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems([.images(item.images.map { $0.url }),
                              .info(title: item.name, price: item.price, createdAt: item.createdAt)])
        view?.applySnapshot(snapshot: snapshot)
    }

    func onCloseButtonTapped() {
        router.dismiss()
    }
}
