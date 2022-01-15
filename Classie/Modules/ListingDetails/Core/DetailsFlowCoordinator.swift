//
//  DetailsFlowCoordinator.swift
//  Classie
//
//  Created by Ilia Gutu on 15.01.2022.
//

import Foundation

protocol DetailsFlowCoordinatorInput {
    func dismiss()
}

final class DetailsFlowCoordinator: BaseCoordinator {

    private let wireframe: Wireframe
    private let listing: Listing

    var whenDone: EmptyAction?

    init(listing: Listing, wireframe: Wireframe) {
        self.listing = listing
        self.wireframe = wireframe
    }

    override func start() {
        runInitialFlow()
    }

    private func runInitialFlow() {
        let viewModule = ListingDetailsModuleAssembly.assembly(listing: listing,
                                                               coordinator: self)
        wireframe.presentEmbedded(viewModule)
    }
}

extension DetailsFlowCoordinator: DetailsFlowCoordinatorInput {
    func dismiss() {
        wireframe.dismissModule()
        whenDone?()
    }
}
