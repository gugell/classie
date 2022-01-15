//
//  ListingDetailsModule.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import UIKit

enum ListingDetailsModuleAssembly {
    static func assembly(listing: Listing,
                         coordinator: DetailsFlowCoordinatorInput) -> Presentable {
        let viewController = ListingDetailsViewController()
        let router = ListingDetailsModuleRouter(coordinator: coordinator)
        let presenter = ListingDetailsModulePresenter(item: listing,
                                                      view: viewController,
                                      router: router)

        viewController.output = presenter

        return viewController
    }
}
